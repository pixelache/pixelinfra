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
  has_many :flickrsets
  #belongs_to :festivaltheme
  has_many :festivalthemes,  through: :festivaltheme_relations
  has_many :festivaltheme_relations, as: :relation, foreign_key: :relation_id
  belongs_to :residency
  has_many :photos, as: :item
  has_many :archivalimages
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
  accepts_nested_attributes_for :videos , reject_if: proc {|x| x['in_url'].blank? }, :allow_destroy => true
  attr_accessor  :place_name, :hide_from_feed
  before_save :update_image_attributes
  validates_presence_of :subsite_id, :place_id, :start_at
  validate :name_present_in_at_least_one_locale
  before_save :check_for_feed
  before_save :check_published
  has_many :feeds, :as => :item, :dependent => :delete_all
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  scope :by_festival, -> festival { where(festival_id: festival) }
  scope :by_subsite, -> subsite { where(subsite_id: subsite ) }
  scope :by_project, -> project { where(project_id: project) }
  scope :by_year, -> year { where(["start_at >= ? AND start_at <= ?", year+"-01-01", year+"-12-31"])}
  scope :by_name, -> (name) { joins(:translations).select("DISTINCT events.* ").where("event_translations.name ILIKE '%" + name + "%'")}

  def all_documentation
    {"images" => [photos + archivalimages].flatten.uniq {|p| p.filename_identifier } ,
     "videos" => videos
    }
  end
  
  def body
    description
  end
  
  def check_published
    if self.user_id.nil?
      self.user_id = 0
    end
    if published == true && hide_from_feed != true
      if self.new_record? 
        add_to_feed('created') unless hide_from_feed == "1"
      else
        add_to_feed('edited') unless hide_from_feed == "1"
      end
    else
      unless feeds.empty?
        feeds.map(&:destroy)
      end
    end
    if hide_from_feed == "1"
      feeds.map(&:destroy)
    end
  end
  
  def has_documentation?
    if all_documentation["images"].empty? && flickrsets.empty? && all_documentation["videos"].empty? 
      if project
        if project.videos.empty?
          return false
        else
          return true
        end
      else
        return false
      end
    else
      return true
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
    if image.present? && image_changed?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
  end

  private
  
  def should_generate_new_friendly_id?
    changed?
  end
  
end
