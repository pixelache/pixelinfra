class Admin::FrontitemsController < Admin::BaseController
  
  def create
    create! { admin_frontitems_path }
  end
  
  def update
    update! { admin_frontitems_path }
  end
  
  protected 
  
  def permitted_params
    params.permit(:frontitem => [:item_type, :subsite_id, :item_id, :frontmodule_id, :position, :external_url, :background_colour, :text_colour, :active])
    
  end
end