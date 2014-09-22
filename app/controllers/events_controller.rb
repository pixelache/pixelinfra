class EventsController < InheritedResources::Base
  actions :index, :show
  
  def index
    @events = Event.by_site(@site).published.order('start_at DESC').page(params[:page]).per(12)
  end
  
  def show
    @event = Event.find(params[:id])
    set_meta_tags :title => @event.name
  end
  
end