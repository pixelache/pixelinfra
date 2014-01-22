class Event < ActiveRecord::Base
  translates :name, :description, :notes, :fallbacks_for_empty_translations => true
  belongs_to :festival
  belongs_to :project
  belongs_to :place
  belongs_to :subsite
  has_many :photos, as: :item
  extend FriendlyId
  friendly_id :name_en , :use => [ :slugged, :finders ] # :history]
  has_paper_trail
  mount_uploader :image, ImageUploader
  resourcify

  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['description'].blank? }
  attr_accessor  :place_name
  before_save :update_image_attributes
  validates_presence_of :subsite_id, :place_id, :start_at, :name

  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  scope :by_festival, -> festival { where(festival_id: festival) }
  scope :by_subsite, -> subsite { where(subsite_id: subsite ) }
  scope :by_project, -> project { where(project_id: project) }
  scope :by_year, -> year { where(["start_at >= ? AND start_at <= ?", year+"-01-01", year+"-12-31"])}
  def name_en
    self.name(:en)
  end
  
  def event_with_date
    self.name + " (#{self.start_at.strftime("%d.%m.%Y")})"
  end
  
  def place_name
    place.blank? ? nil : place.name
  end
  
  def update_image_attributes
    if image.present?
      self.image_content_type = image.file.content_type
      self.image_size = image.file.size
      self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      # if you also need to store the original filename:
      # self.original_filename = image.file.filename
    end
  end
    
end
