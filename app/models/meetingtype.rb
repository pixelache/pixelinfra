class Meetingtype < ActiveRecord::Base
  translates :name
  has_many :meetings
  
  accepts_nested_attributes_for :translations, reject_if: proc {|x| x['name'].blank? }
  
end
