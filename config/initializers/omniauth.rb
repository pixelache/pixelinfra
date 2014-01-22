Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_OMNIAUTH_PROVIDER_KEY'], ENV['GOOGLE_OMNIAUTH_PROVIDER_SECRET']
  provider :facebook, ENV['FACEBOOK_OMNIAUTH_APP_ID'], ENV['FACEBOOK_OMNIAUTH_SECRET'], {:provider_ignores_state => true, :client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  provider :twitter, ENV['TWITTER_OMNIAUTH_APP_ID'], ENV['TWITTER_OMNIAUTH_SECRET']
end
