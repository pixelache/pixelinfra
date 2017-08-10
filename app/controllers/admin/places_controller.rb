class Admin::PlacesController < Admin::BaseController
  handles_sortable_columns
  
  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:notice] = 'Place created.'
      redirect_to admin_places_path
    else
      flash[:error] = 'Error saving place.'
    end
  end
  

  
  def destroy
    @place = Place.friendly.find(params[:id])
    if @place.destroy
      redirect_to  admin_places_path
    end
  end
  
  def edit
    @place = Place.friendly.find(params[:id])

    set_meta_tags :title => t(:edit_place)
  end
  
  def update
    @place = Place.friendly.find(params[:id])
    if @place.update_attributes(place_params)
      redirect_to  admin_places_path 
    end
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
  
  def place_params
    params.require(:place).permit(:address1, :address2, :city, :country, :postcode, :latitude, :longitude, translations_attributes: [:name, :id, :locale])
  end

end