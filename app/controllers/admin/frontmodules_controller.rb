class Admin::FrontmodulesController < Admin::BaseController
  
  def create
    create! { admin_frontmodules_path }
  end
  
  def update
    update! { admin_frontmodules_path }
  end
  
  protected 
  
  def permitted_params
    params.permit(:frontmodule => [:name, :partial_name, :exampleimage])
    
  end
end