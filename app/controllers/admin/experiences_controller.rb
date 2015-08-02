class Admin::ExperiencesController < Admin::BaseController
  
  def index
    @festival = Festival.find(params[:festival_id])
    @festivaltheme = @festival.festivalthemes.find(params[:festivaltheme_id])
    @experiences = @festivaltheme.experiences.order(created_at: :desc)
  end

  def destroy
    destroy! { admin_festival_festivaltheme_experiences_path(@experience.festivaltheme.festival, @experience.festivaltheme) }
  end
  
  def update
    update! { admin_festival_festivaltheme_experiences_path(@experience.festivaltheme.festival, @experience.festivaltheme) }
  end
  protected
  
  def permitted_params
    params.permit(:experience => [:name, :description, :experience_type, :location, :when_text, :start_at,
      :end_at, :place_id, :other_activities, :special_instructions, :email, :latitude, :title, :longitude, :approved, :phone])
  end
  
end