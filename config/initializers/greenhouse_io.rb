GreenhouseIo.configure do |config|
  config.symbolize_keys = true
  config.organization = 'Vonage'
  config.api_token = ENV['GREENHOUSE_API_TOKEN']
end
