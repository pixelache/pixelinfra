I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.default_locale = :en
I18n.available_locales = [:en, :fr, :fi]
I18n.fallbacks[:en] = [:en, :fr, :fi]
I18n.fallbacks[:fi] = [:fi, :fr, :en]

Globalize.fallbacks = {:en => [:en, :fi], :fi => [:fi, :en] }