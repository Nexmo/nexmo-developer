require 'recaptcha'

Recaptcha.configure do |config|
  config.site_key = ENV['RECAPTCHA_V2_SITE_KEY']
  config.secret_key = ENV['RECAPTCHA_V2_SECRET_KEY']
end
