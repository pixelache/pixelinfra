class Feed < ActiveRecord::Base
  belongs_to :subsite
  belongs_to :user
  belongs_to :item,  :polymorphic => true
  
  scope :by_subsite, -> subsite { where(subsite_id: subsite ) }
  validates_presence_of :item
  
end
