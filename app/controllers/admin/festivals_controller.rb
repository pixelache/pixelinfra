class Admin::FestivalsController < Admin::BaseController
  # autocomplete :place, :name
  handles_sortable_columns
  
  
  def create
    create! { admin_festivals_path }
  end
  
  def update
    update! { admin_festivals_path }
  end
  
  def destroy
    destroy! { admin_festivals_path }
  end
  
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "name #{direction}"
      when "dates"
        "start_at #{direction}"
      else
        "start_at"
      end
    end
    @festivals = apply_scopes(Festival).includes(:node).order(order).page(params[:page]).per(20)
  end
 
  protected
  
  def permitted_params
    params.permit(:festival => [:name, :website, :slug, :start_at, :node_id, :remove_image, :festival_id, :end_at, :background_colour, :primary_colour, :image, :published, :subtitle, :slug, :festivalbackdrop, translations_attributes: [:id, :locale, :overview_text]] )
  end
    
end 