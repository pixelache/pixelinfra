module ApplicationHelper
  def date_range(from_date, until_date, options = {})
      options.symbolize_keys!
      format = options[:format] || :short
      separator = options[:separator] || "—"

      if format.to_sym == :short
        month_names = I18n.t("date.abbr_month_names")
      else
        month_names = I18n.t("date.month_names")
      end

      from_day = from_date.day
      from_month = month_names[from_date.month]
      from_year = from_date.year
      until_day = until_date.day

      if from_date.month == until_date.month
        I18n.t("date_range.#{format}.same_month", from_day: from_date.day, until_day: until_date.day, month: from_month, year: from_year, sep: separator)
      else
        until_month = month_names[until_date.month]
        if from_date.year == until_date.year
          I18n.t("date_range.#{format}.different_months_same_year", from_day: from_date.day, from_month: from_month, until_day: until_date.day, until_month: until_month, year: from_year, sep: separator)
        else
          until_year = until_date.year
          I18n.t("date_range.#{format}.different_years", from_day: from_date.day, from_month: from_month, from_year: from_year, until_day: until_date.day, until_month: until_month, until_year: until_year, sep: separator)
        end
      end
    end
    
end
