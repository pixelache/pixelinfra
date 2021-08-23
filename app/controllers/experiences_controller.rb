class ExperiencesController < ApplicationController
  
  def create
    @festivaltheme = Festivaltheme.find(params[:festivaltheme_id])
    @festivaltheme.experiences << Experience.new(permitted_params)
    @festival = @festivaltheme.festival

    if verify_recaptcha && @festivaltheme.save!
      flash[:notice] = 'Thank you for submitting your activity. It will be added to our listings soon.'  

    else
      
      flash[:error] = 'There was an error submitting your activity. Please try again or contact Pixelache if it continues to fail.'
     
    end
   render template: 'festivals/theme'
      
  end
  
  def index
    @festival = Festival.friendly.find(params[:id])
    @festivaltheme = @festival.festivalthemes.find(params[:theme_id])
    @experiences = @festivaltheme.experiences.approved.order(created_at: :desc)
  end
  
  protected
  
  def permitted_params
    params.require(:experience).permit(:name, :phone, :email, :description, :other_activities, :when_text, :location, :experience_type, :special_instructions, :festivaltheme_id)
  end
  
end