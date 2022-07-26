require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_job.queue_adapter = :sidekiq
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      user_name: ENV.fetch('SMTP_USER') { '' },
      password: ENV.fetch('SMTP_PASS') { '' },
      address: ENV.fetch('SMTP_ADDR') { '' },
      domain: ENV.fetch('SMTP_DOMAIN') { '' },
      port: ENV.fetch('SMTP_PORT') { '2525' },
      authentication: :cram_md5
    }

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
