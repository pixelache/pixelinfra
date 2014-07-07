class Admin::AttendeesController < Admin::BaseController
  has_scope :page, :default => 1
  has_scope :by_festival
  
  def index
    @attendees = apply_scopes(Attendee).page(params[:page])
    @filters = Attendee.all.map(&:item).uniq
  end
  
end