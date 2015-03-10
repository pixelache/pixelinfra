class Archivalimage < ActiveRecord::Base
  belongs_to :subsite
  belongs_to :event
  belongs_to :festival
  belongs_to :page
  belongs_to :project
  translates :caption, :fallbacks_for_empty_translations => true
  
  mount_uploader :image, ArchiveimageUploader
  before_save :update_image_attributes
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['caption'].blank?  }
  validates_presence_of :subsite_id, :image
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  scope :by_year, -> (x) { where(["image_date >= ? AND image_date <= ?", "#{x}-01-01", "#{x}-12-31"])}
  attr_accessor  :event_name, :project_name, :festival_name
  
  def activity
    event ? event : (project ? project : (festival ? festival : 'unknown activity'))
  end
  
  def event_name
    event.blank? ? nil : event.event_with_date
  end
  
  def festival_name
    festival.blank? ? nil : festival.name
  end
  
  def filename   # play nice when we aggregate with photos
    image
  end
  def filename_identifier
    image_identifier
  end
  
  
  def item
    activity
  end
  
  def name
    if event
      event.name
    elsif project
      project.name
    elsif festival
      festival.name
    else
      'unknown activity'
    end
  end
  
  def project_name
    project.blank? ? nil : project.name
  end
  
  def update_image_attributes
    if image.present? && image_changed?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
    if self.festival
      self.image_date = self.festival.start_at
    end
    if self.event
      self.image_date = self.event.start_at
    end
  end
  
  def year
    if activity.nil?
      Time.now.year
    else
      if event
        event.start_at.year
      elsif festival
        festival.start_at.year
      else
        Time.now.year
      end
    end
  end
   
end
