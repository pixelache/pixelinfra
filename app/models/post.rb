class Post < ActiveRecord::Base
  acts_as_taggable
  translates :title, :body, :excerpt, :fallbacks_for_empty_translations => true
  belongs_to :subsite
  belongs_to :event
  belongs_to :festival
  belongs_to :project
  belongs_to :creator, :class_name => 'User'
  # belongs_to :class_name, :class_name => 'User'
  extend FriendlyId
  friendly_id :title_en , :use => [ :slugged, :finders, :scoped], :scope => :subsite
  has_and_belongs_to_many :post_categories, join_table: :posts_post_categories
  has_many :photos, as: :item
  has_paper_trail
  mount_uploader :image, ImageUploader
  resourcify

  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['title'].blank? && x['body'].blank? }
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }
  before_save :update_image_attributes
  before_save :check_published
  validates_presence_of :subsite_id

  attr_accessor  :event_name, :project_name, :festival_name
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  scope :by_festival, -> festival { where(festival_id: festival) }
  scope :by_subsite, -> subsite { where(subsite_id: subsite ) }
  scope :by_project, -> project { where(project_id: project) }
  scope :by_year, -> year { where(["published_at >= ? AND published_at <= ?", year+"-01-01", year+"-12-31"])}
    
  def check_published
    if self.published == true
      self.published_at ||= Time.now
    end
    if self.creator_id.blank?
      self.creator_id = self.last_modified_id
    end
  end

  def event_name
    event.blank? ? nil : event.event_with_date
  end
  
  def festival_name
    festival.blank? ? nil : festival.name
  end
  
  def project_name
    project.blank? ? nil : project.name
  end
  
  def posted_by
    if creator_id?
      creator.username
    elsif !wordpress_author.blank?
      wordpress_author
    else
      'unknown'
    end
  end
  
  def title_en
    self.title(:en)
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
