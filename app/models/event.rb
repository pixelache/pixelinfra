class Event < ActiveRecord::Base
  acts_as_taggable_on :tags, :technologies
  translates :name, :description, :notes, :fallbacks_for_empty_translations => true
  belongs_to :festival
  belongs_to :project
  belongs_to :place
  belongs_to :subsite
  belongs_to :step
  belongs_to :user
  has_many :posts
  has_many :photos, as: :item
  has_many :videos
  extend FriendlyId
  friendly_id :name_en , :use => [ :slugged, :finders ] # :history]
  has_paper_trail
  mount_uploader :image, ImageUploader
  resourcify
  has_event_calendar
  include Feedable
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['description'].blank? }
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }, :allow_destroy => true
  attr_accessor  :place_name, :hide_from_feed
  before_save :update_image_attributes
  validates_presence_of :subsite_id, :place_id, :start_at
  validate :name_present_in_at_least_one_locale
  after_create :check_for_feed
  before_save :check_published
  has_many :feeds, :as => :item, :dependent => :delete_all
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  scope :by_festival, -> festival { where(festival_id: festival) }
  scope :by_subsite, -> subsite { where(subsite_id: subsite ) }
  scope :by_project, -> project { where(project_id: project) }
  scope :by_year, -> year { where(["start_at >= ? AND start_at <= ?", year+"-01-01", year+"-12-31"])}
  scope :by_name, -> (name) { joins(:translations).where("event_translations.name ILIKE '%" + name + "%'")}

  
  def body
    description
  end
  
  def check_published
    if published == true && hide_from_feed != true
      if self.new_record? 
        add_to_feed('created')
      else
        add_to_feed('edited')
      end
    else
      unless feeds.empty?
        feeds.map(&:destroy)
      end
    end
  end
  
  def name_en
    self.name(:en)
  end
  
  def name_present_in_at_least_one_locale
    if I18n.available_locales.map { |locale| translation_for(locale).name }.compact.empty?
      errors.add(:base, "You must specify an event name in at least one available language.")
    end
  end
    
  def event_with_date
    self.name + " (#{self.start_at.strftime("%d.%m.%Y")})"
  end
  
  def feed_time
    start_at
  end
  
  def happens_on?(day)
    if end_at.blank?
      return true if day.to_date == start_at.to_date
    else
      return true if day.to_date >= start_at.to_date && day.to_date <= end_at.to_date
    end
  end
  
  def stream_date
    start_at.to_date
  end
  
  def endstream_date
    end_at.nil? ? nil : end_at.to_date
  end
    
  def place_name
    place.blank? ? nil : place.name
  end
  
  def title
    name    
  end
  
  def update_image_attributes
    if image.present?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
  end

  
end
