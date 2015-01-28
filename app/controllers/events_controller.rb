class EventsController < InheritedResources::Base
  actions :index, :show
  
  def index
    @events = Event.by_site(@site).published.order('start_at DESC').page(params[:page]).per(12)
    set_meta_tags title: t(:events)
  end
  
  def show
    @event = Event.find(params[:id])
    if @event.festival
      @festival = @event.festival
    end
    if request.xhr?
      render :template => 'events/ajax_event', layout: false
    end
    set_meta_tags :title => @event.name
  end
  
end