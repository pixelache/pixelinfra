class EventsController < InheritedResources::Base
  actions :index, :show
  
  def index
    @events = Event.by_site(@site).published.order('start_at DESC').page(params[:page]).per(6)
  end
  
end