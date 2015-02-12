class Admin::ProjectsController < Admin::BaseController
  
  def create
    create! { admin_projects_path }
  end
  
  def update
    update! { admin_projects_path }
  end
  
  def destroy
    destroy! { admin_projects_path }
  end
  
  def subscribe
    @project = Project.find(params[:id])
    @project.subscribe_to_list(current_user)
    redirect_to [:admin, @project]
  end
  
  def unsubscribe
    @project = Project.find(params[:id])
    @project.unsubscribe_from_list(current_user)
    redirect_to [:admin, @project]
  end  
  
  protected
  
  def permitted_params
    params.permit(:project => [:name, :slug, :parent_id, :website, :evolvedfrom_id, :project_bg_colour, :project_text_colour, :project_link_colour, :redirect_to, :background, :remove_background, :evolution_year, :has_listserv, :listservname, :website, :active, translations_attributes: [:description, :short_description, :id, :locale], photos_attributes: [:id, :filename, :_destroy], videos_attributes: [:id, :in_url, :_destroy], attachments_attributes: [:id, :attachedfile, :_destroy]])
  end
    
end 