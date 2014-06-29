# Patch for rails3-jquery-autocomplete to work with globalize3.
# (based on rails3-jquery-autocomplete 1.0.11)
module Rails3JQueryAutocomplete
  module Orm
    module ActiveRecord
      #
      # def self.included(base)
      #   base.send :include, InstanceMethods
      #   base.send :alias_method_chain, :get_autocomplete_items, :globalize3
      #   base.send :alias_method_chain, :get_autocomplete_select_clause, :globalize3
      # end
      #
      # module InstanceMethods

        def active_record_get_autocomplete_items(parameters)
          model             = parameters[:model]
          translated_model  = find_globalized_column_class_for(model, parameters[:method])
          model_with_method = translated_model || model
          term    = parameters[:term]
          method  = parameters[:method]
          options = parameters[:options]
          scopes  = Array(options[:scopes])
          where   = options[:where]
          limit   = get_autocomplete_limit(options)
          order   = get_autocomplete_order(method, options, model_with_method)

          items = (::Rails::VERSION::MAJOR * 10 + ::Rails::VERSION::MINOR) >= 40 ? model.where(nil) : model.scoped

          if scopes.present?
            scopes.each { |scope| items = items.send(scope) }
          end

          unless options[:full_model]
            items = items.select(get_autocomplete_select_clause(model, model_with_method, method, options))
          end

          if translated_model.present?
            items = items.with_translations(Globalize.locale)
          end

          items = items.where(get_autocomplete_where_clause(model_with_method, term, method, options)).
              limit(limit).order(order)

          items = items.where(where) if where.present?

          items.all.uniq
        end

        def get_autocomplete_select_clause(model_with_pk, model_with_method, method, options)
          pk_table_name = model_with_pk.table_name
          m_table_name  = model_with_method.table_name

          (["#{pk_table_name}.#{model_with_pk.primary_key}", "LOWER(#{m_table_name}.#{method})"] +
            (options[:extra_data].presence || []))
        end

        # If the attribute of the record is globalized, returns the translation class; otherwise, returns nil.
        def find_globalized_column_class_for(record, attribute)
          if record.respond_to?(:translation_class) && record.translated_attribute_names.include?(attribute)
            record.translation_class
          else
            nil
          end
        end

      # end

    end
  end
end