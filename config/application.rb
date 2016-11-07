require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RcmdLinkage
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    config.time_zone = 'Tokyo'
    I18n.enforce_available_locales = false
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    
    config.assets.paths << "#{Rails}/assets/fonts"
    
    #config.autoload_paths += Dir["#{config.root}/lib"]
    config.autoload_paths += %W(#{config.root}/lib)
    #config.autoload_paths += Dir["#{config.root}/lib/**/"]
    
  end
end
