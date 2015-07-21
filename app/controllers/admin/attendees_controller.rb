class Admin::AttendeesController < Admin::BaseController
  has_scope :page, :default => 1
  has_scope :by_festival
  has_scope :by_event
  
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
  
end