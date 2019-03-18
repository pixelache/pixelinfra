class Admin::FestivalthemesController < Admin::BaseController

  def create
    @festivaltheme = Festivaltheme.new(festivaltheme_params)
    if @festivaltheme.save
      flash[:notice] = 'Festival theme created.'
      redirect_to admin_festivals_path
    else
      flash[:error] = 'Error saving festivaltheme.'
    end
  end

  def destroy
    @festivaltheme = Subsite.find(params[:subsite_id]).festivalthemes.find(params[:id])
    @festivaltheme.destroy!
    redirect_to admin_festival_path(@festivaltheme.festival)
  end

  def edit
    @festival = Festival.friendly.find(params[:festival_id])
    @festivaltheme = @festival.festivalthemes.find(params[:id])
    set_meta_tags :title => t(:edit_festivaltheme)
  end

  def new
    @festival = Festival.friendly.find(params[:festival_id])
    @festivaltheme = Festivaltheme.new(:festival => @festival)
  end

  def update
    @festival = Festival.friendly.find(params[:festival_id])
    @festivaltheme = @festival.festivalthemes.find(params[:id])
    if @festivaltheme.update_attributes(festivaltheme_params)
      redirect_to  admin_festivals_path
    end
  end

  private

  def festivaltheme_params
    params.require(:festivaltheme).permit(:festival_id, :image, translations_attributes: [:id, :locale, :short_description, :name, :description])
  end
  
end
