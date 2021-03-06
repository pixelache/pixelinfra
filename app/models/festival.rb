class Festival < ActiveRecord::Base
  belongs_to :node
  has_many :events, :dependent => :nullify
  has_and_belongs_to_many :etherpads
  has_many :posts
  has_many :attendees, as: :item
  has_many :festivalthemes
  has_many :attachments, as: :item
  # has_many :projects
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]
  has_event_calendar
  validates_presence_of :name, :node_id
  has_many :pages
  has_one :step
  has_many :videos
  mount_uploader :image, ImageUploader
  mount_uploader :festivalbackdrop, AttachmentUploader
  translates :overview_text, :fallbacks_for_empty_translations => true
  belongs_to :subsite
  
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['overview_text'].blank? }
  accepts_nested_attributes_for :attachments, :reject_if => proc {|x| x['attachedfile'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :videos , reject_if: proc {|x| x['in_url'].blank? }, :allow_destroy => true
  
  before_save :update_image_attributes
  has_many :subscriptions, as: :item
  scope :by_node, -> (x) { includes(:node).where(:node_id => x) }
  scope :published,  -> () { where(published: true)}
  scope :by_year, -> year { where(["start_at >= ? AND start_at <= ?", year+"-01-01", year+"-12-31"])} 
  before_save :check_listserv_support
  include Listable
  
  def subscribe_path
    '/admin/festivals/' + self.slug + '/subscribe'
  end
  
  def body
    description
  end
  
  def toggle_path
    '/admin/festivals/' + self.slug + '/toggle_list'
  end
  
  
  def unsubscribe_path
    '/admin/festivals/' + self.slug + '/unsubscribe'
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
  
  def description
    overview_text(:en)
  end
  
  def in_future?
    end_at > Time.now
  end

  def to_hashtag
    "##{name.gsub(/\s*/, '')}"
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
  
end
