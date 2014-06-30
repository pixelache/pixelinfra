class Festival < ActiveRecord::Base
  belongs_to :node
  has_many :events, :dependent => :nullify
  has_and_belongs_to_many :etherpads
  has_many :posts
  # has_many :projects
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]
  has_event_calendar
  validates_presence_of :name, :node_id
  has_many :pages
  mount_uploader :image, ImageUploader
  translates :overview_text, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['overview_text'].blank? }
  before_save :update_image_attributes

  
  def happens_on?(day)
    if end_at.blank?
      return true if day.to_date == start_at.to_date
    else
      return true if day.to_date >= start_at.to_date && day.to_date <= end_at.to_date
    end
  end
  
  def description
    overview_text(:en)
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
