require 'i18n/backend/fallbacks'

I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.fallbacks.map(cn: :"zh-CN")
I18n.available_locales = :en
