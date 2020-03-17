require 'i18n/backend/fallbacks'

I18n::Backend::Simple.include I18n::Backend::Fallbacks
I18n.fallbacks.map(cn: :"zh-CN")
I18n.available_locales = %i[en cn]
I18n.fallbacks[:cn] = [:en]
I18n.default_locale = :en
