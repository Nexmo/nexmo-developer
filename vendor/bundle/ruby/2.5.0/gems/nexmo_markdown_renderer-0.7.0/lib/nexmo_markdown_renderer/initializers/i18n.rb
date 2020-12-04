require 'i18n'

I18n.load_path += Dir[File.join("#{GEM_ROOT}/config/locales".freeze, '*.yml'.freeze)]
I18n.default_locale = :en
