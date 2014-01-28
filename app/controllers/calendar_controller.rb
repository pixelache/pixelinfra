class CalendarController < ApplicationController
  
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)
    @first_day_of_week = 1
    start_d, end_d = Event.get_start_and_end_dates(@shown_month, @first_day_of_week)
    @festivals = Festival.events_for_date_range(start_d, end_d)
    @events = Event.events_for_date_range(start_d, end_d)
    @event_strips = Event.create_event_strips(start_d, end_d, @events + @festivals)
  end
  
end
