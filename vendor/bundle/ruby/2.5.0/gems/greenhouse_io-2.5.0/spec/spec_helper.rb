require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'rubygems'
require 'bundler'
require 'webmock/rspec'
require 'vcr'
require 'greenhouse_io'

RSpec.configure do |config|
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
  config.ignore_hosts 'codeclimate.com'
end

def restore_default_config
  GreenhouseIo.configuration = nil
  GreenhouseIo.configure {}
end
