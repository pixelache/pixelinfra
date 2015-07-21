class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, polymorphic: true
  before_destroy :update_waiting_list
  
  scope :by_festival, -> (festival) { where(:item_id => festival, :item_type => "Festival")}
  
  def update_waiting_list
    if item.is_full? && waiting_list == false
      n = Attendee.where(:waiting_list => true, :event => item).order(:created_at).first
      if !n.blank?
        n.waiting_list = false
        n.save!
        AttendeeMailer.waitinglist_notification(n)
      end
    end
  end
  
  
end
