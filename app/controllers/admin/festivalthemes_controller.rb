class Admin::FestivalthemesController < Admin::BaseController
  
  def create 
    create! { admin_festivals_path }
  end
  
  def update
    update! { admin_festivals_path }
  end
  
  def new
    @festival = Festival.find(params[:festival_id])
    @festivaltheme = Festivaltheme.new(:festival => @festival)
  end
  private
  
  def permitted_params
    params.permit(:festivaltheme => [:festival_id, translations_attributes: [:id, :locale, :name, :description]])
  end
  
end
