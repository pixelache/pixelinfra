class Admin::FestivalsController < Admin::BaseController
  # autocomplete :place, :name
  
  
  def create
    create! { admin_festivals_path }
  end
  
  def update
    update! { admin_festivals_path }
  end
  
  def destroy
    destroy! { admin_festivals_path }
  end
  
 
  protected
  
  def permitted_params
    params.permit(:festival => [:name, :website, :start_at, :festival_id, :end_at, :slug] )
  end
    
end 