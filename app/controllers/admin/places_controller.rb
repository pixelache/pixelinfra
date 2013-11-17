class Admin::PlacesController < Admin::BaseController

  def create
    create! { admin_places_path }
  end
  
  def update
    update! { admin_places_path }
  end
  
  def set_fi
    @place = Place.friendly.find(params[:id])
  end
  
  protected
  
  def permitted_params
    params.permit(:place => [:address1, :address2, :city, :country, :postcode, :latitude, :longitude, translations_attributes: [:name, :id, :locale]])
  end

end