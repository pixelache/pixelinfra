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
    params.permit(:project => [:name, :slug, :parent_id, :website, :evolvedfrom_id, :evolution_year, :website, translations_attributes: [:description, :id, :locale], photos_attributes: [:id, :filename]])
  end
    
end 