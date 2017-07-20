source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0.rc1'
gem 'webpacker', github: 'rails/webpacker'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# A fast, safe and extensible Markdown to (X)HTML parser
gem 'redcarpet', '~> 3.4.0'

# Rouge aims to a be a simple, easy-to-extend drop-in replacement for pygments.
gem 'rouge', '~> 2.0.7'

# Toolkit for processing input using filters and pipelines
gem 'banzai', '~> 0.1.2'

# ZURB Foundation on Sass/Compass
gem 'foundation-rails', '6.3.0.0'

# Nokogiri (鋸) is an HTML, XML, SAX, and Reader parser. Among Nokogiri's many features is the ability to search documents via XPath or CSS3 selectors.
gem 'nokogiri', '1.7.0.1'

# Autoload dotenv in Rails.
gem 'dotenv-rails', groups: [:development, :test]

# Administrate is heavily inspired by projects like Rails Admin and ActiveAdmin, but aims to provide a better user experience for site admins
gem 'administrate', '~> 0.4.0'

# Ruby/ProgressBar is a text progress bar library for Ruby.
gem 'ruby-progressbar'

gem 'rubocop'

# Ruby notifier for bugsnag.com
gem 'bugsnag'

# Extends String class or add a ColorizedString with methods to set text color, background color and text effects.
gem 'colorize'

# A simple Ruby client for the algolia.com REST API
gem 'algoliasearch'

# Wicked is a Rails engine for producing easy wizard controllers
gem 'wicked'

# Redis for Ruby on Rails
gem 'redis', '~> 3.3'

gem 'pusher'
gem 'nexmo'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rawler', git: 'git://github.com/oscardelben/rawler.git', require: false
  gem 'rspec-rails', '~> 3.5'
  gem 'foreman'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-livereload', '~> 2.5', require: false
  gem "better_errors"
  gem "binding_of_caller"
  gem "pry"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
