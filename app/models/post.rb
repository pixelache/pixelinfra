class Post < ActiveRecord::Base
  translates :title, :body, :excerpt, :fallbacks_for_empty_translations => true
  belongs_to :subsite
  belongs_to :creator, :class_name => 'User'
  belongs_to :last_modified, :class_name => 'User'
  extend FriendlyId
  friendly_id :title_en , :use => [ :slugged, :finders, :scoped], :scope => :subsite
  
  has_paper_trail
  mount_uploader :image, ImageUploader
  resourcify

  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['title'].blank? && x['body'].blank? }
  before_save :update_image_attributes
  before_save :check_published
  validates_presence_of :subsite_id

  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  
  def check_published
    if self.published == true
      self.published_at ||= Time.now
    end
    if self.creator_id.blank?
      self.creator_id = self.last_modified_id
    end
  end

  
  def title_en
    self.title(:en)
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
