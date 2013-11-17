I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.default_locale = :en
I18n.available_locales = [:en, :fi]
I18n.fallbacks[:en] = [:en, :fi]
I18n.fallbacks[:fi] = [:fi, :en]

Globalize.fallbacks = {:en => [:en, :fi], :fi => [:fi, :en] }