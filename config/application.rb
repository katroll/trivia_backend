require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TriviaBackend
  class Application < Rails::Application
    config.load_defaults 7.0

    config.api_only = true

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.action_dispatch.cookies_same_site_protection = :none
    config.force_ssl = true unless Rails.env.development?
    config.action_controller.allow_forgery_protection = false
  end

end
