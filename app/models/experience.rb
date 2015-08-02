class Experience < ActiveRecord::Base
  belongs_to :festivaltheme
  belongs_to :place
  
  scope :approved, -> () { where(approved: true)}
end
