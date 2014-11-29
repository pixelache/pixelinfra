class Flickrset < ActiveRecord::Base
  belongs_to :event
  belongs_to :project
  belongs_to :festival
  belongs_to :subsite
  validates_presence_of :flickr_id, :subsite_id
  
  attr_accessor :event_name
  
  before_save :get_last_mod_date
  
  def get_last_mod_date
    if last_modified_date.blank?
      FlickRaw.api_key= ENV['FLICKR_API_KEY']
      FlickRaw.shared_secret= ENV['FLICKR_API_SECRET']
      set = flickr.photosets.getInfo(:photoset_id => flickr_id)
      self.last_modified_date = Time.at(set.date_update.to_i).to_date
    end
  end
  
  def flickr_url
    "https://www.flickr.com/photos/#{flickr_user}/sets/#{flickr_id}/"
  end
  
  def event_name
    event.blank? ? nil : event.event_with_date
  end
end
