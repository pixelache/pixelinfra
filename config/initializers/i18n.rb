I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.default_locale = :en
I18n.available_locales = [:en, :fi, :sv, :ru]
I18n.fallbacks[:en] = [:en, :fi, :sv, :ru]
I18n.fallbacks[:fi] = [:fi, :en, :sv, :ru]
I18n.fallbacks[:sv] = [:sv, :en, :fi, :ru]
I18n.fallbacks[:ru] = [:ru, :en, :sv, :fi]

Globalize.fallbacks = { en: [:en, :fi, :sv, :ru], fi: [:fi, :sv, :en, :ru], sv: [:sv, :en, :fi, :ru], ru: [:ru, :en, :sv, :fi] }
I18n.enforce_available_locales = false