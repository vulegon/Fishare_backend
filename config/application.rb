require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require 'dotenv/load'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    
    # config.action_mailer.default_url_options = { host: 'fishare-backend.fly.dev.com' }
    #   config.action_mailer.delivery_method = :smtp
    # config.action_mailer.smtp_settings = {
    #   address: 'smtp.gmail.com',
    #   domain: 'gmail.com',
    #   port: 587,
    #   user_name: ENV['GMAIL_USER_EMAIL'],
    #   password: ENV['GMAIL_PASSWORD'],
    #   authentication: :login
    # }

    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies # Required for all session management
    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options
    config.middleware.use ActionDispatch::Flash
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        # 今回はRailsのポートが3001番、Reactのポートが3000番にするので、Reactのリクエストを許可するためにlocalhost:3000を設定
        origins '*'
        resource '*',
                 :headers => :any,
                 # この一文で、渡される、'access-token'、'uid'、'client'というheaders情報を用いてログイン状態を維持する。
                 :expose => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
                 :methods => [:get, :post, :options, :delete, :put]
      end
    end

    # デフォルトのロケールを:en以外に変更する
    config.i18n.default_locale = :ja
  end
end
