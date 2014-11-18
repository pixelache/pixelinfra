class Admin::ResidenciesController < Admin::BaseController
  
  def create
    create! { admin_residencies_path }
  end
  
  def update
    update! { admin_residencies_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:residency => [:name, :country, :start_at, :country_override, :end_at, :is_micro, :slug, :photo, :project_id, :user_id,  translations_attributes: [:id, :locale, :description]])
  end
  
end