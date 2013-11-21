class Admin::NodesController < Admin::BaseController
  autocomplete :place, :name
  
  
  def create
    create! { admin_nodes_path }
  end
  
  def update
    update! { admin_nodes_path }
  end
  
  def destroy
    destroy! { admin_nodes_path }
  end
  
 
  
  protected
  
  def permitted_params
    params.permit(:node => [:name, :website, :city, :country, :logo, :logo_width, :place_name, :logo_height, :logo_content_type, :logo_size,   translations_attributes: [:description, :id, :locale]])
  end
    
end 