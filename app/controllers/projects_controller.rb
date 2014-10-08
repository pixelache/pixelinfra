class ProjectsController < InheritedResources::Base
  respond_to :html, :js
  
  def show
    @project = Project.find(params[:id])
    @activities = @project.posts.published.order('published_at desc')
    @activities += @project.self_and_descendants.map{|x| x.events.published }.flatten.sort_by(&:start_at).reverse
    @activities = Kaminari.paginate_array(@activities.flatten.sort_by{|x| x.stream_date }.reverse).page(params[:page]).per(8)
    set_meta_tags :title => @project.name
    super
  end
  
end