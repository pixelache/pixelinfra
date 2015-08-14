class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, polymorphic: true
  validates_presence_of :email
  
  scope :by_festival, -> (festival) { where(:item_id => festival, :item_type => "Festival")}
  scope :by_event, -> (event) { where(:item_id => event, :item_type => "Event")}
  scope :not_waiting, -> () { where("waiting_list is not true")}

  
end
