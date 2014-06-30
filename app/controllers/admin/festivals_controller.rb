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
    params.permit(:festival => [:name, :website, :start_at, :node_id, :remove_image, :festival_id, :end_at, :background_colour, :primary_colour, :image, :subtitle, :slug, translations_attributes: [:id, :locale, :overview_text]] )
  end
    
end 