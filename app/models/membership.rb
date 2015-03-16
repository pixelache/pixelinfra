class Membership < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :year
  
  scope :paid, -> () { where(paid: true) }
end
