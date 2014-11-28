class Admin::FlickrsetsController < Admin::BaseController
  has_scope :page, :default => 1
  handles_sortable_columns
  autocomplete :event, :name, :extra_data => [:start_at], :display_value => :event_with_date
    
  def create
    create! { admin_flickrsets_path }
  end
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "title"
        "LOWER(title) #{direction}"
      when "last_modified_date"
        "last_modified_date #{direction}"
      when "site"
        "subsites.name #{direction}"
      else
        "last_modified_date DESC"
      end
    end
    @flickrsets = apply_scopes(Flickrset).includes(:subsite).order(order).page(params[:page]).per(30)      
  end
  
  def update
    update! { admin_flickrsets_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:flickrset => [:subsite_id, :project_id, :flickr_id, :title, :description, :event_id, :festival_id])
  end
  
end