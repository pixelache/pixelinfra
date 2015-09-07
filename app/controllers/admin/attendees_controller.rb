class Admin::AttendeesController < Admin::BaseController
  has_scope :page, :default => 1
  has_scope :by_festival
  has_scope :by_event
  has_scope :by_post 
  
  def edit
    @attendee = Attendee.find(params[:id])
    @filters = Attendee.all.map(&:item).uniq.sort_by(&:feed_time).reverse
  end
  
  def index
    @attendees = apply_scopes(Attendee).order(created_at: :desc).page(params[:page]).per(50)
    @filters = Attendee.all.map(&:item).uniq.sort_by(&:feed_time).reverse
  end
  
  def destroy
    @attendee = Attendee.find(params[:id])


    if @attendee.item.is_full? # && !waiting_list != true
      n = Attendee.where(:waiting_list => true, :item => @attendee.item).order(:created_at).first
      if !n.blank?
        n.waiting_list = false
        n.save!
        AttendeeMailer.waitinglist_notification(n).deliver
      end
    end
    @attendee.destroy
    redirect_to "/admin/attendees?by_#{@attendee.item_type.downcase}=#{@attendee.item_id}"
  end
  
  def update
    update! { admin_attendees_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:attendee  => [:name, :phone, :email, :item_id, :motivation_statement, :project_creators, :project_description])
  end
  
end