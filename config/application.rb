require_relative "boot"

require "rails/all"
require 'digest'
require "bcrypt"

# require "active_model/railtie"
# require "active_record/railtie"
# require "active_controller/railtie"
# require "action_view/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AuthApp
  class Application < Rails::Application
    config.load_defaults 7.0

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore

    config.action_dispatch.cookies_same_site_protection = :strict


    config.api_only = true
  end
end
