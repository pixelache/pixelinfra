class Festival < ActiveRecord::Base
  belongs_to :node
  has_many :events
  # has_many :projects
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]
  
  validates_presence_of :name, :node_id
  
end
