Recaptcha.configure do |config|
  config.public_key  = ENV['RECAPTCHA_PUBLIC']
  config.api_version = 'v1'
  config.private_key = ENV['RECAPTCHA_PRIVATE']
end