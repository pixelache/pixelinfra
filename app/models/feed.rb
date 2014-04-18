class Feed < ActiveRecord::Base
  belongs_to :subsite
  belongs_to :user
  belongs_to :item,  :polymorphic => true
  
end
