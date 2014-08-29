class Admin::DocumenttypesController < Admin::BaseController
  
  def create
    create! { admin_documenttypes_path }
  end
  
  def update
    update! { admin_documenttypes_path }
  end
  
  def destroy
    destroy! { admin_documenttypes_path }
  end
  
 
  
  protected
  
  def permitted_params
    params.permit(:documenttype => [:name, :parent_id])
  end
    
end 