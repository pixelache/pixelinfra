Recaptcha.configure do |config|
  config.public_key  = ENV['RECAPTCHA_PUBLIC']
  config.api_version = 'v2'
  config.private_key = ENV['RECAPTCHA_PRIVATE']
end