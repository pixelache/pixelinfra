class Admin::ProjectsController < Admin::BaseController


  def show
    @project = Project.friendly.find(params[:id])
  end
    
  def edit
    @project = Project.friendly.find(params[:id])
    
  end
  
  def new
    @project = Project.new
  end
  
  def index
    @projects = Project.all
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = 'Project created.'
      redirect_to admin_projects_path
    else
      flash[:error] = 'Error saving project.'
    end
  end
  
  def update
    @project = Project.friendly.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:notice] = 'Project updated.'
      redirect_to admin_projects_path
    else
      flash[:error] = 'Error updating project.'
    end
 
  end
  
  def destroy
    @project = Project.friendly.find(params[:id])
    if @project.destroy
      flash[:notice] = 'Project deleted.'
    end
    redirect_to admin_projects_path
  end
  
  def subscribe
    @project = Project.find(params[:id])
    @project.subscribe_to_list(current_user)
    redirect_to [:admin, @project]
  end
    
  def subscribe_other
    @project = Project.find(params[:id])
    email = params[:email]
    # not elegant but will fix later
    if User.find_by(email: params[:email]).nil?
      @project.subscribe_to_list(params[:email])
 
    else
      @project.subscribe_to_list(User.find_by(email: params[:email]))
    end
    redirect_to admin_project_path(@project)
  end
    
  def toggle_list
    @project = Project.find(params[:id])
    current_user.subscribed_to?(@project) ? @project.unsubscribe_from_list(current_user) : @project.subscribe_to_list(current_user)
    @status = current_user.subscribed_to?(@project)
    respond_to do |format|
      format.js   #note.. not .json
    end
  end
  
  def unsubscribe
    @project = Project.find(params[:id])
    @project.unsubscribe_from_list(current_user)
    redirect_to [:admin, @project]
  end  
  
  protected
  
  def project_params
    params.require(:project).permit(:name, :slug, :parent_id, :website, :evolvedfrom_id, :hidden, :project_bg_colour,
       :project_text_colour, :project_link_colour, :redirect_to, :background, :remove_background,
        :evolution_year, :has_listserv, :listservname, :website, :active, 
        translations_attributes: [:description, :short_description, :id, :locale], 
        photos_attributes: [:id, :filename, :_destroy], 
        videos_attributes: [:id, :in_url, :_destroy], 
        attachments_attributes: [:id, :year_of_publication, :attachedfile,:title, :description, :public, :item_type, 
          :item_id, :documenttype_id,  :_destroy])
  end
    
end 