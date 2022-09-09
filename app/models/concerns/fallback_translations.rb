module FallbackTranslations
  extend ActiveSupport::Concern

  module ClassMethods
    def with_fallback_translations
      preload(:translations)
        .joins("INNER JOIN (
          SELECT #{self.table_name}.id, #{selected_fallback_fields}
          FROM #{self.table_name}
          LEFT JOIN #{self.translations_table_name} original ON #{self.table_name}.id = original.#{translations_foreign_key} AND original.locale = '#{Globalize.fallbacks[0]}'
          LEFT JOIN #{self.translations_table_name} fallback ON #{self.table_name}.id = fallback.#{translations_foreign_key} AND fallback.locale = '#{Globalize.fallbacks[1]}'
        ) #{self.translations_table_name} ON #{self.translations_table_name}.id = #{self.table_name}.id")
    end

    def selected_fallback_fields
      coalesce_array = []

      self.translated_attribute_names.each do |t|
        coalesce_array << "COALESCE(original.#{t}, fallback.#{t}) as #{t}"
      end

      coalesce_array.join(", ")
    end

    def translations_foreign_key
      reflect_on_association(:translations).foreign_key
    end
  end
end