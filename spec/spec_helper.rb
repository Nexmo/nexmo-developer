require 'rack/test'
require 'rubygems'
require 'byebug'
require 'capybara/rspec'
require 'factory_bot'
require 'database_cleaner/active_record'
require 'bundler/setup'

# Load station's gems and app
station_dir = Gem::Specification.find_by_name('station').gem_dir
require "#{station_dir}/lib/nexmo_developer/nexmo_developer"
require "#{station_dir}/lib/nexmo_developer/config/environment"

Capybara.app = Rack::Builder.new.run Rails.application

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    # set host, otherwise rack-test fails
    Rails.application.routes.default_url_options[:host] = 'test.host'

    # load factories
    FactoryBot.find_definitions
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      # Driver is probably for an external browser with an app
      # under test that does *not* share a database connection with the
      # specs, so use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end
end
