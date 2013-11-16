class Admin::EventsController < Admin::BaseController
  
  def create
    create! { admin_events_controller }
  end
  
  def update
    update! { admin_events_controller }
  end
  
  def destroy
    destroy! { admin_events_controller }
  end
  
  protected
  
  def permitted_params
    params.permit(:event => [:subsite_id, :place_id, :start_at, :end_at, :published, :image, :image_width, :image_height, :image_content_type, :image_size, :facebook_link, :cost, :cost_alternate, :cost_alternate_reason,
      translations_attributes: [:name, :description, :notes]])
  end
    
end