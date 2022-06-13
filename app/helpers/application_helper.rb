module ApplicationHelper
  
  def hover_colour(colour)
    "#{colour.match(/(..)(..)(..)/).to_a[1..3].map{|x| [[0, x.hex + ( x.hex * -0.15)].max, 255].min }.map{|x| x.to_i.to_s }.join(', ')}"
  end
  
  def dimension(resource)
    if resource.image?
      if !resource.image_width.nil?
        if resource.image_width >= resource.image_height
          return "landscape"
        else
          return "portrait"
        end
      else
        return ""
      end
    else
      return ""
    end
  end
  
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
    if until_date.nil? # || from_date.class == Date
      if from_date.class == Date
        return I18n.l(from_date.to_date, :format => :long)
      elsif from_date.range_time.blank? 
        return I18n.l(from_date.to_date, :format => :short)
      else
        return I18n.l(from_date, :format => :long)
      end
    else
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
          if until_date.strftime("%H:%M") == from_date.strftime("%H:%M")
            if from_date.strftime("%H:%M") == "00:00"
              I18n.t("date_range.#{format}.same_day_no_time", from_day: from_date.day, from_month: from_month, year: from_date.year, start_time: from_date.strftime("%H:%M"), sep: separator, end_time: until_date.strftime("%H:%M"), :format => :long)      
            else
              I18n.t("date_range.#{format}.same_day_start_time", from_day: from_date.day, from_month: from_month, year: from_date.year, start_time: from_date.strftime("%H:%M"), sep: separator, end_time: until_date.strftime("%H:%M"), :format => :long)      
            end
          else
            I18n.t("date_range.#{format}.same_day", from_day: from_date.day, from_month: from_month, year: from_date.year, start_time: from_date.strftime("%H:%M"), sep: separator, end_time: until_date.strftime("%H:%M"), :format => :long)
          end
        elsif from_date.class == Date && until_date.class == Date
          I18n.t("date_range.#{format}.same_month_no_time", from_day: from_date.day, until_day: until_date.day, month: from_month, year: from_year, sep: separator, start_time: nil, end_time: nil)
        else
          I18n.t("date_range.#{format}.same_month", from_day: from_date.day, until_day: until_date.day, month: from_month, year: from_year, sep: separator, start_time: from_date.range_time, end_time: until_date.range_time)
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
  end


  def determine_hierarchy(cssclass = :active, parent = nil, items = [ ] )
    items.each do |i|
      next if i.nil?
      if i.class == Page && parent.class == Page
        if (parent.self_and_descendants & [i]).empty?  
          return false
        else
          return cssclass
        end
      elsif i.class == Festivaltheme
        if parent.slug == 'programme'
          return cssclass
        elsif i == parent
          return cssclass
        else
          return false
        end
      elsif i.class == Event
        if parent.slug == 'programme' || i.festivalthemes.include?(parent) || i == parent
          return cssclass
        else
          return false
        end
      else
        return false
      end
    end
  end
  
  def figure_width(resource, default = "medium-12")
    if resource.image.nil?
      return default
    else
      if resource.image_width.nil?
        return default
      else
        if resource.image_width > 1200
          return default
        elsif resource.image_width > 999
          return "medium-10"
        elsif resource.image_width > 800
          return "medium-8"
        else
          return "medium-7"
        end
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
     
  def magellanise(text, sections)
    if sections.empty?
      return text
    else
      toreturn = "<section data-magellan-target=\"top\">" + text
      sections.each do |s|
        next if s.first == 'top'
        toreturn.gsub!(/<a id=\"#{s.first}\"/, "</section><section data-magellan-target=\"#{s.first}\"><a class='section_heading' id=\"#{s.first}\"" )
      end
      return toreturn + "</section>"
    end
    
  end
  
  def ordinalize_number number
      case I18n.locale
      when :en
          return number.ordinalize
      when :fi
          return number.to_s + ".9"
      else
          return number
      end
  end  

  def pluralize_sentence(count, i18n_id, plural_i18n_id = nil)
    if count == 1
      I18n.t(i18n_id, :count => count)
    else
      I18n.t(plural_i18n_id || (i18n_id + "_plural"), :count => count)
    end
  end
    
  def pixelache_format(text, html_options = {}, options = {})
    text = '' if text.nil?
    text = smart_truncate(text, options[:truncate]) if options[:truncate].present?
    text = sanitize(text, tags: %w{a bold img b strong iframe italic h1 h2 h3 h4 h5 h6 b i em br p}, attr: %w{href src width align height}) unless options[:sanitize] == false
    text = text.to_str
    text.gsub!(/\r\n?/, "\n") # \r\n and \r -> \n
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline -> br
    text.html_safe
  end
end
