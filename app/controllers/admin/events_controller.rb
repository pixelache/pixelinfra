class Admin::EventsController < Admin::BaseController
  autocomplete :place, :name
  autocomplete :event, :name
  handles_sortable_columns
  has_scope :by_subsite
  has_scope :by_project
  has_scope :by_festival
  has_scope :by_year
  has_scope :by_name
  
  def create
    create! { admin_events_path }
  end
    
  def edit
    @event = Event.friendly.find(params[:id])
    super
  end

  def index
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "LOWER(slug) #{direction}"
      when "published"
        "published #{direction}, start_at #{direction}"
      when "when"
        "start_at #{direction}"
      else
        "start_at DESC"
      end
    end
    @events = apply_scopes(Event).includes(:subsite).order(order).page(params[:page]).per(30)
  end

  def update
    update! { admin_events_path }
  end
  
  def destroy
    destroy! { admin_events_path }
  end
  

  protected
  
  def permitted_params
    params.permit(:event => [:subsite_id, :place_id, :start_at, :end_at, :published, :image, :image_width, :place_name, :image_height, :image_content_type, :image_size, :facebook_link, :cost, :cost_alternate, :cost_alternate_reason, :project_id, :festival_id, :facilitator_name, :facilitator_url, :facilitator_organisation, :user_id, :hide_from_feed, :user_id, :resources_needed, :protocol, 
      :facilitator_organisation_url, :tag_list, :technology_list,
      photos_attributes: [:id, :filename, :filename_content_type],
      translations_attributes: [:name, :description, :notes, :id, :locale]])
  end
    
end 