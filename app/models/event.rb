class Event < ActiveRecord::Base
  belongs_to :place
  belongs_to :subsite
  extend FriendlyId
  friendly_id :name_en, :use => [:finders, :history]
  has_paper_trail
  mount_uploader :image, ImageUploader
  resourcify
  translates :name, :description, :notes, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['description'].blank? }
  attr_accessor  :place_name
  before_save :update_image_attributes
  validates_presence_of :subsite_id, :place_id, :start_at

  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  
  def name_en
    self.name(:en)
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
