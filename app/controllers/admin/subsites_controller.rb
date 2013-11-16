class Admin::SubsitesController < Admin::BaseController
  def create
    create! { admin_subsites_path }
  end
  
  def update
    update! { admin_subsites_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:subsite => [:name, :description, :subdomain])
  end
  
end
