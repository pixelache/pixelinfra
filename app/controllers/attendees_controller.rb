class AttendeesController < ApplicationController
  
  def create
    if params[:event_id]
      @item = Event.friendly.find(params[:event_id])
      @attendee = Attendee.new(permitted_params)
      if @item.is_full?
        @attendee.waiting_list = true
      end
      @item.attendees << @attendee
    end
    if params[:post_id]
      begin
        @item = @site.posts.friendly.find(params[:post_id])

      rescue ActiveRecord::RecordNotFound
        if @site.festival
          @item = @site.festival.posts.friendly.find(params[:post_id])
        end
      end
      @attendee = Attendee.new(permitted_params)
      if @item.is_full?
        @attendee.waiting_list = true
      end
      @item.attendees << @attendee
    end
    
    if verify_recaptcha && @item.save!
      if @item.class == Post
        if !@item.email_template.blank?

          eval("AttendeeMailer.#{@item.email_template}(@attendee).deliver_now")
        end
      else
        AttendeeMailer.registration_notification(@attendee).deliver_now
        AttendeeMailer.enduser_notification(@attendee).deliver_now
      end
      flash[:notice] = 'Thank you for registering.'  
    else
      
      flash[:error] = 'There was an error submitting your registration. Please try again or contact Pixelache if it continues to fail.'
     
    end
   # render template: "#{@item.class.to_s.tableize}/show"
   redirect_to @item
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
