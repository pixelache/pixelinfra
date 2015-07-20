class AttendeesController < ApplicationController
  
  def create
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @event.attendees << Attendee.new(permitted_params)
    end
    if verify_recaptcha && @event.save!
      flash[:notice] = 'Thank you for registering. You should receive a confirmation email.'  

    else
      
      flash[:error] = 'There was an error submitting your registration. Please try again or contact Pixelache if it continues to fail.'
     
    end
   render template: 'events/show'
      
  end

  
  protected
  
  def permitted_params
    params.require(:attendee).permit(:name, :phone, :email, :motivation_statement, :project_creators, :project_description)
  end

end
