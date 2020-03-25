source 'https://rubygems.org'
ruby '2.5.7'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2'
gem 'webpacker'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.1.20'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Add clipboard for copying content
gem 'clipboard-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Add Geocoder to get latitude and longitude for geographic places
gem 'geocoder'

# Add gmap4rails to integrate the Google Maps API
gem 'gmaps4rails'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser. Among Nokogiri's many features is the ability to search documents via XPath or CSS3 selectors.
gem 'nokogiri', '~> 1.10.9'

# Autoload dotenv in Rails.
gem 'dotenv-rails', groups: %i[development test]

# Ruby/ProgressBar is a text progress bar library for Ruby.
gem 'ruby-progressbar', require: false

# Ruby notifier for bugsnag.com
gem 'bugsnag'

# Extends String class or add a ColorizedString with methods to set text color, background color and text effects.
gem 'colorize'

# A simple Ruby client for the algolia.com REST API
gem 'algoliasearch'

# A simple HTTP and REST client for Ruby, inspired by the Sinatra microframework style of specifying actions: get, put, post, delete.
gem 'rest-client'

# Helpers for the reCAPTCHA API
gem 'recaptcha', require: 'recaptcha/rails'

# Implements the iCalendar specification (RFC-5545) in Ruby.
gem 'icalendar', require: false

# Generate JSON strings from Ruby objects with flexible formatting options.
gem 'neatjson'

# Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
gem 'faker', '2.10.2', require: false

# factory_girl_rails provides integration between factory_girl and rails 3 or newer (currently just automatic factory definition loading)
gem 'factory_bot_rails', '5.1.1', require: false

# A slim ruby wrapper for posting to slack webhooks
gem 'slack-notifier', '2.3.2'

# The administration framework for Ruby on Rails.
gem 'activeadmin', '~> 2.6'

# Flexible authentication solution for Rails with Warden
gem 'devise', '>= 4.6.0'

# Simple wrapper for the GitHub API
gem 'octokit', require: false

# Cross-language UserAgent classifier library, ruby implementation
gem 'woothee'

# Create beautiful JavaScript charts with one line of Ruby
gem 'chartkick', '3.3.1'

# The simplest way to group temporal data
gem 'groupdate', '5.0.0'

# A configurable and documented Rails view helper for adding gravatars into your Rails application.
gem 'gravatar_image_tag', '1.2.0'

# Boot large ruby/rails apps faster
gem 'bootsnap', require: false

# Convenient diffing in ruby
gem 'diffy', require: false

# Automatic Ruby code style checking tool. Aims to enforce the community-driven Ruby Style Guide.
gem 'rubocop', '~> 0.79.0', require: false
gem 'rubocop-rails', '~> 2.4', require: false

# Volta needs a CSS autoprefixer
gem 'autoprefixer-rails'

# Titleize modifies the existing Titleize Rails functionality to better suit our needs
gem 'titleize'

# Used in our reporting rake tasks
gem 'terminal-table'

# Single line logging for production
gem 'lograge'

# Country picker for ActiveAdmin
gem 'countries'
gem 'country_select', '~> 4.0'

gem 'nexmo_markdown_renderer', git: 'https://github.com/Nexmo/nexmo-markdown-renderer', branch: 'fix-voice-snippets'

gem 'nexmo-oas-renderer', '~> 0.9', require: false

gem 'smartling'

gem 'newrelic_rpm'

# A/B Testing
gem 'split', '~> 3.4.1', require: 'split/dashboard'

gem 'greenhouse_io'

# For truncating HTML strings
gem 'truncato'

gem 'redis'

gem 'barnes'

gem 'actionpack-page_caching', github: 'rails/actionpack-page_caching'

group :development, :test do
  gem 'awesome_print'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry', require: false
  gem 'rawler', git: 'https://github.com/oscardelben/rawler.git', require: false
  gem 'rspec-collection_matchers'
  gem 'rspec-rails', '~> 4.0'
  gem 'rspec-snapshot', '~> 0.1.2'
  gem 'simplecov', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'guard-rspec'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Much nicer error experience, including repl
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'capybara'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# The following are dependencies of dependencies, but we require them here to
# force minimum versions due to security issues
gem 'ffi', '>= 1.9.24'
gem 'rack', '>= 2.0.6'
