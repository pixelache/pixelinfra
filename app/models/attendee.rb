class Attendee < ActiveRecord::Base
  belongs_to :user

  belongs_to :item, polymorphic: true
  
  scope :by_festival, -> (festival) { where(:item_id => festival, :item_type => "Festival")}
  
end
