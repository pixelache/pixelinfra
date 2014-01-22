class Festival < ActiveRecord::Base
  belongs_to :node
  has_many :events
  has_and_belongs_to_many :etherpads
  # has_many :projects
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]
  
  validates_presence_of :name, :node_id
  
end
