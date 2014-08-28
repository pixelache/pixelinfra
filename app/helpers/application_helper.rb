module ApplicationHelper
  
  def best_image(resource)
    if resource.image?
      if !resource.image_width.nil?
        if resource.image_width >= 1200
          if resource.image.twelvehundred.file.exists?
            image_tag resource.image.url(:twelvehundred)
          else
            image_tag resource.image.url
          end
        else
          image_tag resource.image.url
        end
      else
        image_tag resource.image.url
      end
    end
  end
  

  def break_string_on_spaces(string, position, counter = 18)
    out = Array.new
    base = [0, find_nearest_space(string, position, counter)].flatten.compact
    base.each_with_index do |position, index|
      if index+1 == base.size
        out << string.slice(position..string.length).strip
      else
        out << string.slice(position..base[index+1]).strip
      end
    end
    return out
  end
  
  def date_range(from_date, until_date, options = {})
    return I18n.l(from_date.to_date, :format => :long) if until_date.nil?
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
        if from_date.day == until_date.day
          I18n.l(from_date.to_date, :format => :long)
        else
          I18n.t("date_range.#{format}.same_month", from_day: from_date.day, until_day: until_date.day, month: from_month, year: from_year, sep: separator)
        end
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

  
  def find_nearest_space(string, start, counter = 18)
    return nil if string.nil?
    if start > string.length
      return
    else
      start.downto(start-counter) do |char|    
        splitchar = char
        if string.slice(char..char) =~ /\s/
          return Array.new.push(char, find_nearest_space(string, char + counter))
        end
      end
    end
  end
        
end
