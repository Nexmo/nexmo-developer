require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NexmoDeveloper
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.middleware.use Rack::Deflater

    config.autoload_paths << "#{Rails.root}/app/constraints"
    config.autoload_paths << "#{Rails.root}/lib"
    config.autoload_paths += Dir[File.join(Rails.root, 'lib', 'open_api', '*.rb')].each { |l| require l }
    config.autoload_paths += Dir[File.join(Rails.root, 'lib', 'core_ext', '*.rb')].each { |l| require l }
    config.autoload_paths += Dir[File.join(Rails.root, 'lib', 'decorators', '*.rb')].each { |l| require l }
    config.autoload_paths += Dir[File.join(Rails.root, 'app', 'extensions', '**', '*.rb')].each { |l| require l }

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
