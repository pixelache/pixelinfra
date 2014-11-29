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
  
 
  
  protected
  
  def permitted_params
    params.permit(:project => [:name, :slug, :parent_id, :website, :evolvedfrom_id, :project_bg_colour, :project_text_colour, :project_link_colour, :evolution_year, :website, :active, translations_attributes: [:description, :id, :locale], photos_attributes: [:id, :filename, :_destroy], videos_attributes: [:id, :in_url, :_destroy], attachments_attributes: [:id, :attachedfile, :_destroy]])
  end
    
end 