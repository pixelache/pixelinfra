class EventsController < InheritedResources::Base
  actions :index, :show
  
  def index
    @events = Event.by_site(@site).published.page(params[:page]).per(6)
  end
  
end