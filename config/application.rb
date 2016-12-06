require_relative 'boot'

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pixelinfra
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.encoding = "utf-8"
    config.middleware.insert 0, Rack::UTF8Sanitizer
    config.time_zone = 'Helsinki'
     # config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_types = [:datetime, :time]
    config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 8.hours }
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    config.session_store :cookie_store, :key => '_pixelache_session', :domain => :all
    config.assets.paths << Rails.root.join("app", "assets",  "fonts")

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      
      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      
      
      g.view_specs false
      g.helper_specs false
    end

  end
end
I18n.enforce_available_locales = false