# -*- encoding : utf-8 -*-
module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  def calendar(options = {}, &block)
    block ||= Proc.new {|d| nil}

    defaults = {
      :year => (Time.zone || Time).now.year,
      :month => (Time.zone || Time).now.month,
      :abbrev => true,
      :first_day_of_week => 0,
      :show_today => true,
      :show_header => true,
      :month_name_text => (Time.zone || Time).now.strftime("%B %Y"),
      :previous_month_text => nil,
      :next_month_text => nil,
      :event_strips => [],

      # it would be nice to have these in the CSS file
      # but they are needed to perform height calculations
      :width => "100%",
      :height => 500,
      :day_names_height => 18,
      :day_nums_height => 18,
      :event_height => 18,
      :event_margin => 1,
      :event_padding_top => 2,

      :use_all_day => false,
      :use_javascript => true,
      :link_to_day_action => false
    }
    options = defaults.merge options

    # default month name for the given number
    if options[:show_header]
      options[:month_name_text] ||= I18n.translate(:'date.month_names')[options[:month]]
    end

    # make the height calculations
    # tricky since multiple events in a day could force an increase in the set height
    height = options[:day_names_height]
    row_heights = cal_row_heights(options)
    row_heights.each do |row_height|
      height += row_height
    end

    # the first and last days of this calendar month
    if options[:dates].is_a?(Range)
      first = options[:dates].begin
      last = options[:dates].end
    else
      first = Date.civil(options[:year], options[:month], 1)
      last = Date.civil(options[:year], options[:month], -1)
    end

    # create the day names array [Sunday, Monday, etc...]
    day_names = []
    if options[:abbrev]
      day_names.concat(I18n.translate(:'date.abbr_day_names'))
    else
      day_names.concat(I18n.translate(:'date.day_names'))
    end
    options[:first_day_of_week].times do
      day_names.push(day_names.shift)
    end

    # Build the HTML string
    cal = ""

    # outer calendar container
    cal << %(<div class="ec-calendar")
    cal << %(style="width: 100%;") if options[:width]
    cal << %(>)

    # table header, including the monthname and links to prev & next month
    if options[:show_header]
      cal << %(<table class="ec-calendar-header" cellpadding="0" cellspacing="0">)
      cal << %(<thead><tr>)
      if options[:previous_month_text] or options[:next_month_text]
        cal << %(<th colspan="2" class="ec-month-nav ec-previous-month">#{options[:previous_month_text]}</th>)
        colspan = 3
      else
        colspan = 7
      end
      cal << %(<th colspan="#{colspan}" class="ec-month-name">#{options[:month_name_text]}</th>)
      if options[:next_month_text]
        cal << %(<th colspan="2" class="ec-month-nav ec-next-month">#{options[:next_month_text]}</th>)
      end
      cal << %(</tr></thead></table>)
    end

    # body container (holds day names and the calendar rows)
    cal << %(<div class="ec-body" style="height: #{height}px;">)

    # day names
    cal << %(<table class="ec-day-names" style="height: #{options[:day_names_height]}px;" cellpadding="0" cellspacing="0">)
    cal << %(<tbody><tr>)
    day_names.each do |day_name|
      cal << %(<th class="ec-day-name" title="#{day_name}">#{day_name}</th>)
    end
    cal << %(</tr></tbody></table>)

    # container for all the calendar rows
    cal << %(<div class="ec-rows" style="top: #{options[:day_names_height]}px; )
    cal << %(height: #{height - options[:day_names_height]}px;">)

    # initialize loop variables
    first_day_of_week = beginning_of_week(first, options[:first_day_of_week])
    last_day_of_week = end_of_week(first, options[:first_day_of_week])
    last_day_of_cal = end_of_week(last, options[:first_day_of_week])
    row_num = 0
    top = 0

    things = options[:event_strips].flatten.compact.uniq
    has_events = []
    has_image = []
      
    # go through a week at a time, until we reach the end of the month
    while(last_day_of_week <= last_day_of_cal)
      cal << %(<div class="ec-row" style="top: #{top}px; height: #{row_heights[row_num]}px;">)
      top += row_heights[row_num-1]

      # this weeks background table
      cal << %(<table class="ec-row-bg" cellpadding="0" cellspacing="0">)
      cal << %(<tbody><tr>)

      first_day_of_week.upto(first_day_of_week+6) do |day|
      
        today_class = (day == Date.today) ? "ec-today-bg" : ""
        other_month_class = (day < first) || (day > last) ? 'ec-other-month-bg' : ''
        bg = ''
        elink  = ''
        ftext = ''
        festival_text = ''
        image_list = []
        things.each do |t|
          if t.happens_on?(day)
            has_events.push(day)
            
            if t.class == Event
              bg = t.image.url(:thumb) 
              image_list.push(t.image.url(:thumb))
            end
            elink = url_for(t)
            if t.start_at.to_date == day.to_date
              has_image.push(day)
              ftext += '<a href="' + url_for(t) + '" class="' + t.class.to_s + '">  '
              if other_month_class != "ec-other-month-bg"
                ftext += image_tag t.image.url(:thumb)  if t.class == Event
                #'<img src="' + bg + '">' if bg
              end
              
              # if festival, put just the name of the festival
              if t.class == Festival
                festival_text = '<div class="festival_info"><div class="festival_title">' + t.name + '</div>'
              end

              ftext += '<div class="event_info"><div class="event_title ' + t.class.to_s.downcase + 's">' 
              
              # break depending on day of calendar
              if day.wday == 0 || (t.end_at.to_date == t.start_at.to_date)
                ftext += break_string_on_spaces(t.name, 18).join('<br />') 
              elsif day.wday == 6
                ftext += break_string_on_spaces(t.name, 36, 36).join('<br />') 
              elsif day.wday == 5
                ftext += break_string_on_spaces(t.name, 54, 54).join('<br />') 
              else
                ftext += t.name
              end
              

                ftext += '</div></div></a>'

            elsif t.end_at.to_date == day.to_date
              has_image.push(day)
              ftext += '<a href="' + elink + '">' 
              if other_month_class != "ec-other-month-bg"
                ftext += image_tag t.image.url(:thumb)  if t.class == Event
                # "<img src=\"#{bg}\">"
              end
              ftext += "<div class=\"event_last\"><div>"
              ftext += "<span class=\"small\">".html_safe + t(:last_day) + ": #{break_string_on_spaces(t.name, 18).join('<br />')}</span>".html_safe
              ftext +=  "</div></div></a>"
            else

              today_class += " middle_event"
              if day.day == 1 && other_month_class != "ec-other-month-bg"
                ftext += '<a href="' + elink + '" class="' + t.class.to_s + '">' 
                ftext +=  image_tag t.image.url(:thumb) 
                ftext += '<div class="event_info"><div class="event_title">' 
              
                # break depending on day of calendar
                if day.wday == 0 || (t.end_at.to_date == t.start_at.to_date)
                  ftext += break_string_on_spaces(t.name, 30, 30).join('<br />') 
                elsif day.wday == 6
                  ftext += break_string_on_spaces(t.name, 36, 36).join('<br />') 
                elsif day.wday == 5
                  ftext += break_string_on_spaces(t.name, 54, 54).join('<br />') 
                else
                  ftext += t.name
                end
                ftext += '</div></div></a>'
              elsif day == beginning_of_week(first, options[:first_day_of_week])
                if other_month_class == "ec-other-month-bg"
                  ftext += "<div class=\"event_arrow\">&#8594;</div></a>"
                else
                  ftext += "<a href=\"#{url_for(t)}\">"
                  ftext += image_tag t.image.url(:thumb) 
                  image_list.push(t.image.url(:thumb))
                  ftext += "<div class=\"event_info\"><span class=\"event_title\">"
                  ftext += break_string_on_spaces(truncate(t.name, :length => 35),18).join('<br />') + '</span><Br />'
                  ftext += "<span class=\"event_metadata\">&#8592;</span></div></a>"
                end
                  
              else    
                ftext += "<a href=\"#{url_for(t)}\">"
                if other_month_class != "ec-other-month-bg"
                  
                  if t.class == Event
                    ftext += image_tag t.image.url(:thumb)  
                    image_list.push(t.image.url(:thumb))
                  end
                  #"<img src=\"#{bg}\">"
                end
                ftext += "<div class=\"event_arrow\">&#8594;</div></a>"
                if t.class == Festival
                  festival_text = "<div class=\"festival_arrow\">&#8594; </div></a>"
                end
              end
            end
          end

        end
	ftext = ftext.force_encoding('utf-8')
        cal << %(<td class="ec-day-bg #{today_class} #{other_month_class} #{has_events.select{|element| has_events.count(element) > 1 }.include?(day) ? "ec-multiple-events" : false} #{(has_image.include?(day) ? "ec-has-image" : false)}">)
        # multiple events on the day, so ... SLIDESHOW
        if has_events.select{|element| has_events.count(element) > 1 }.include?(day)
          cal << "<div class=\"multiple\">" + has_events.select{|x| x == day }.count.to_s + " events today</div>"
          unless image_list.compact.empty?
            if image_list.compact.size == 1
              cal << '<img src="' + i + '">'
            else
              cal << '<ul data-orbit>'
              image_list.compact.uniq.each do |i|
                cal << '<li><img src="' + i.gsub(/development/, 'production') + '"></li>'
              end
              cal << '</ul>'
            end
          end
          unless festival_text.blank?
            cal  << %(#{festival_text}&nbsp;</td>)
          end
        else
          cal << %(#{ftext}&nbsp;</td>)
        end
      end
      cal << %(</tr></tbody></table>)

      # calendar row
      cal << %(<table class="ec-row-table" cellpadding="0" cellspacing="0">)
      cal << %(<tbody>)

      # day numbers row
      cal << %(<tr>)
      wday = t('date.abbr_day_names')
      first_day_of_week.upto(last_day_of_week) do |day|
        cal << %(<td class="ec-day-header )
        cal << %(ec-has-event ) if has_events.include?(day)
        cal << %(ec-today-header ) if options[:show_today] and (day == Date.today)
        cal << %(ec-other-month-header ) if (day < first) || (day > last)
        cal << %(ec-weekend-day-header) if weekend?(day)
        cal << %(" style="height: #{options[:day_nums_height]}px;">)
        if options[:link_to_day_action]
          cal <<  day_link(day.day, day, options[:link_to_day_action]) 
        else
          cal << "<span class=\"day_link\">" + %(#{wday[day.wday]} / #{day.day}) + "</span>"
        end
        cal << %(</td>)
      end
      cal << %(</tr>)
      # 
      # event rows for this day
      #  for each event strip, create a new table row
      #  options[:event_strips].each do |strip|
      #    cal << %(<tr>)
      #    # go through through the strip, for the entries that correspond to the days of this week
      #    strip[row_num*7, 7].each_with_index do |event, index|
      #      day = first_day_of_week + index
      #    
      #      if event
      #        # get the dates of this event that fit into this week
      #        dates = event.clip_range(first_day_of_week, last_day_of_week)
      #        # if the event (after it has been clipped) starts on this date,
      #        # then create a new cell that spans the number of days
      #        if dates[0] == day.to_date
      #          # check if we should display the bg color or not
      #          no_bg = no_event_bg?(event, options)
      #          class_name = event.class.name.tableize.singularize
      #    
      #          cal << %(<td class="ec-event-cell" colspan="#{(dates[1]-dates[0]).to_i + 1}" )
      #          cal << %(style="padding-top: #{options[:event_margin]}px;">)
      #          cal << %(<div id="ec-#{class_name}-#{event.id}" class="ec-event )
      #          if class_name != "event"
      #            cal << %(ec-#{class_name} )
      #          end
      #          if no_bg
      #            cal << %(ec-event-no-bg" )
      #            cal << %(style="color: #{event.color}; )
      #          else
      #            cal << %(ec-event-bg" )
      #            cal << %(style="background-color: #{event.color}; opacity: 0.79; )
      #          end
      #    
      #          cal << %(padding-top: #{options[:event_padding_top]}px; )
      #          cal << %(height: #{options[:event_height] - options[:event_padding_top]}px;" )
      #          if options[:use_javascript]
      #            # custom attributes needed for javascript event highlighting
      #            cal << %(data-event-id="#{event.id}" data-event-class="#{class_name}" data-color="#{event.color}" )
      #          end
      #          cal << %(>)
      #    
      #          # add a left arrow if event is clipped at the beginning
      #          if event.start_at.to_date < dates[0]
      #            cal << %(<div class="ec-left-arrow"></div>)
      #          end
      #          # add a right arrow if event is clipped at the end
      #          if event.end_at.to_date > dates[1]
      #            cal << %(<div class="ec-right-arrow"></div>)
      #          end
      #    
      #          if no_bg
      #            cal << %(<div class="ec-bullet" style="background-color: #{event.color};"></div>)
      #            # make sure anchor text is the event color
      #            # here b/c CSS 'inherit' color doesn't work in all browsers
      #            cal << %(<style type="text/css">.ec-#{class_name}-#{event.id} a { color: #{event.color}; }</style>)
      #          end
      #    
      #          if block_given?
      #            # add the additional html that was passed as a block to this helper
      #            cal << block.call({:event => event, :day => day.to_date, :options => options})
      #          else
      #            # default content in case nothing is passed in
      #            cal << %(<a href="/#{class_name.pluralize}/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
      #          end
      #    
      #          cal << %(</div></td>)
      #        end
      #    
      #      else
      #        # there wasn't an event, so create an empty cell and container
      #        cal << %(<td class="ec-event-cell ec-no-event-cell" )
      #        cal << %(style="padding-top: #{options[:event_margin]}px;">)
      #        cal << %(<div class="ec-event" )
      #        cal << %(style="padding-top: #{options[:event_padding_top]}px; )
      #        cal << %(height: #{options[:event_height] - options[:event_padding_top]}px;" )
      #        cal << %(>)
      #        cal << %(&nbsp;</div></td>)
      #      end
      #   end
      #   cal << %(</tr>)
      # end

      cal << %(</tbody></table>)
      cal << %(</div>)

      # increment the calendar row we are on, and the week
      row_num += 1
      first_day_of_week += 7
      last_day_of_week += 7
    end

    cal << %(</div>)
    cal << %(</div>)
    cal << %(</div>)
      
  end
    
      
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>",
      :use_all_day => true,
      :first_day_of_week => @first_day_of_week,
      :width => 952,
      :height => 630
    }
  end

  def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event, day = args[:event], args[:day]
      html = %(#{event.class.to_s}: <a href="/events/#{event.id}" title="#{h(event.name)}">)
      html << display_event_time(event, day) if event.class == Event
      html << %(#{h(event.name)} sd</a>)
      html
    end
  end
end
