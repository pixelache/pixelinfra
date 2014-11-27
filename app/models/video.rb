class Video < ActiveRecord::Base
  belongs_to :event
  belongs_to :project
  belongs_to :festival
  belongs_to :videohost
  
  scope :by_subsite, ->(x) { where(subsite_id: x ) }
  scope :published, -> {  where(published: true)  }
  
  mount_uploader :thumbnail, ImageUploader
  
  attr_accessor :in_url
  
  before_validation :populate_other_fields  
  validates_presence_of :videohost_id, :hostid
  
  def populate_other_fields
    
    if in_url =~ /youtube/ || in_url =~ /youtu\.be/
      client = YouTubeIt::Client.new(:dev_key => YOUTUBE_API)
      self.hostid = in_url.match(/^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/)[7] || 'error'
      self.videohost_id = 2
      v = client.video_by(hostid)
      self.title = v.title
      self.description = v.description
      self.remote_thumbnail_url = v.thumbnails.sort_by(&:width).last.url rescue nil
      self.duration = v.duration
    elsif in_url =~ /vimeo/
      self.hostid = in_url.match(/^\D*\/(\d*).*/)[1] || 'error'
      self.videohost_id = 1
      v = Vimeo::Simple::Video.info(hostid).first
      self.title = v['title']
      self.description = v['description']
      self.remote_thumbnail_url = v['thumbnail_large']
      self.video_width = v['width']
      self.video_height = v['height']
      self.duration = v['duration']
    end
    if thumbnail.present?
      self.thumbnail_content_type = thumbnail.file.content_type
      self.thumbnail_size = thumbnail.file.size
      self.thumbnail_width, self.thumbnail_height = `identify -format "%wx%h" #{thumbnail.file.path}`.split(/x/)
    end
    if hostid == 'error' || hostid.blank?
      errors.add(:hostid, "Could not load video with this URL")
    end
    if videohost_id.blank?
      errors.add(:videohost_id, "Videohost needs to be YouTube or Vimeo")
    end
    
    if event_id
      if event.project
        self.project_id = event.project_id
      end
      if event.festival
        self.festival_id = event.festival_id
      end
    end
      
  end
  
  def in_url
    url
  end
  
  def url
    videohost_id == 1 ? "http://www.youtube.com/watch?v=#{hostid}" : "http://vimeo.com/#{hostid}"
  end
  
  def video_provider
    videohost.name
  end
  
end
