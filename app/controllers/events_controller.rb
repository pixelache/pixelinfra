class EventsController < InheritedResources::Base
  actions :index, :show
  
  def index
    if params[:festival_id]
      @festival = Festival.find(params[:festival_id])
      @events = Event.by_site(@site).by_festival(@festival).published.order('published_at DESC').page(params[:page]).per(12)
      set_meta_tags title: @festival.name + " " + t(:events)
    elsif params[:project_id]
      @project = Project.find(params[:project_id])
      @events = Kaminari.paginate_array(@project.self_and_descendants.visible.map{|x| x.events.published }.flatten.sort_by(&:start_at).reverse).page(params[:page]).per(12)
      set_meta_tags title: @project.name + " " + t(:events)
    else
      @events = Event.by_site(@site).published.order('start_at DESC').page(params[:page]).per(12)
      set_meta_tags title: t(:events)
    end
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