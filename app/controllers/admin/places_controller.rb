class Admin::PlacesController < Admin::BaseController
  handles_sortable_columns
  
  def create
    create! { admin_places_path }
  end
  
  def update
    update! { admin_places_path }
  end
  
  def index
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "LOWER(place_translations.name) #{direction}"
      when "address"
        "address #{direction}, start_at #{direction}"

      else
        "LOWER(place_translations.name)"
      end
    end
    @places = Place.joins(:translations).order(order).page(params[:page]).per(50)
    set_meta_tags :title => t(:places)
  end
  
  def set_fi
    @place = Place.friendly.find(params[:id])
  end
  
  protected
  
  def permitted_params
    params.permit(:place => [:address1, :address2, :city, :country, :postcode, :latitude, :longitude, translations_attributes: [:name, :id, :locale]])
  end

end