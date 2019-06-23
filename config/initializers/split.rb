Split.configure do |config|
  config.enabled = !!ENV['REDIS_URL']
end
