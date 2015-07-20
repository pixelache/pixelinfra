class ExperiencesController < ApplicationController
  
  def create
    @festivaltheme = Festivaltheme.find(params[:festivaltheme_id])
    @festivaltheme.experiences << Experience.new(permitted_params)
    if @festivaltheme.save!
      flash[:notice] = 'Thank you for submitting your activity. It will be added to our listings soon.'
      redirect_to festival_path(@festivaltheme.festival)
    else
      flash[:error] = 'There was an error submitting your activity. Please try again or contact Pixelache if it continues to fail.'
    end

      
  end
  
  protected
  
  def permitted_params
    params.require(:experience).permit(:name, :phone, :email, :description, :other_activities, :when_text, :location, :experience_type, :special_instructions, :festivaltheme_id)
  end
  
end