class Flickrset < ActiveRecord::Base
  belongs_to :event
  belongs_to :project
  belongs_to :festival
  belongs_to :subsite
  validates_presence_of :flickr_id, :subsite_id
  
  attr_accessor :event_name
end
