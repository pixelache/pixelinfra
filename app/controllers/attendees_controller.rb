class AttendeesController < ApplicationController
  
  def create
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @attendee = Attendee.new(permitted_params)
      if @event.is_full?
        @attendee.waiting_list = true
      end
      @event.attendees << @attendee
    end
    if verify_recaptcha && @event.save!
      AttendeeMailer.registration_notification(@attendee).deliver_now
      # if @event.is_full?
      #   AttendeeMailer.waitinglist_notification(@attendee).deliver
      # else
      AttendeeMailer.enduser_notification(@attendee).deliver_now
      # end
      flash[:notice] = 'Thank you for registering. You should receive a confirmation email.'  

    else
      
      flash[:error] = 'There was an error submitting your registration. Please try again or contact Pixelache if it continues to fail.'
     
    end
   render template: 'events/show'
      
  end

  def index
    if params[:event_id]
      @event = Event.find(params[:event_id])
      redirect_to @event
    end
    
  end
  
  protected
  
  def permitted_params
    params.require(:attendee).permit(:name, :phone, :email, :motivation_statement, :project_creators, :project_description)
  end

end
