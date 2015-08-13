class Post < ActiveRecord::Base
  acts_as_taggable
  translates :title, :body, :excerpt, :fallbacks_for_empty_translations => true
  belongs_to :subsite
  belongs_to :residency
  belongs_to :event
  belongs_to :festival
  belongs_to :project
  belongs_to :creator, :class_name => 'User'
  # belongs_to :class_name, :class_name => 'User'
  extend FriendlyId
  friendly_id :title_en , :use => [ :slugged, :finders, :scoped], :scope => :subsite
  has_and_belongs_to_many :post_categories, join_table: :posts_post_categories
  has_many :photos, as: :item
  has_many :attachments, as: :item
  has_paper_trail
  mount_uploader :image, ImageUploader
  resourcify
  has_many :attendees, as: :item
  has_many :feeds, :as => :item, :dependent => :delete_all
  include Feedable
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['title'].blank? || x['body'].blank? }
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :attachments, :reject_if => proc {|x| x['attachedfile'].blank? && x['title'].blank? && x['description'].blank? && x['documenttype_id'].blank? }, :allow_destroy => true
  before_save :update_image_attributes
  before_save :check_published
  # before_save :check_festival_site
  validates_presence_of :subsite_id
  #validate :title_present_in_at_least_one_locale
  after_save :check_for_feed
  attr_accessor  :event_name, :project_name, :festival_name, :hide_from_feed
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  scope :by_festival, -> festival { where(festival_id: festival) }
  scope :by_subsite, -> subsite { where(subsite_id: subsite ) }
  scope :by_project, -> project { where(project_id: project) }
  scope :by_user, -> (x) { where(["last_modified_id = ? OR creator_id = ?", x, x] ) }
  scope :by_year, -> year { where(["published_at >= ? AND published_at <= ?", year+"-01-01", year+"-12-31"])}
  scope :is_pixelache, -> () { where(external: false) }
  scope :is_external, -> () { where(external: true) }
  scope :by_tag, -> tag{ joins(:taggings).where(:taggings => {:tag_id => tag}) }
  scope :by_name, -> (name) { joins(:translations).where("post_translations.title ILIKE '%" + name + "%'")}
  scope :interviews, -> () { joins(:post_categories).where("post_categories.name ILIKE '%interviews'") }
  
  def check_festival_site
    if self.festival
      if self.festival.subsite
        self.subsite = self.festival.subsite
      end
    elsif self.project
      if self.project.subsite
        self.subsite = self.project.subsite
      end
    end
    
  end
          
          
  def check_published
    if self.published == true
      self.published_at ||= Time.now
      unless self.persisted? || hide_from_feed != false
        add_to_feed('created')
      end
    else
      unless feeds.empty?
        feeds.map(&:destroy)
      end
    end
    if self.creator_id.blank?
      self.creator_id = self.last_modified_id
    end
    if hide_from_feed == "1"
      feeds.delete_all
    end
  end
  
  def category
    post_categories.map(&:name).join(' / ')
  end
  
  def description
    body
  end
  
  def event_name
    event.blank? ? nil : event.event_with_date
  end
  
  def feed_time
    published_at
  end
  
  def festival_name
    festival.blank? ? nil : festival.name
  end
  
  def name
    title
  end
  

  def is_full?
    if registration_required

        if !max_attendees.blank?
          if max_attendees - self.attendees.to_a.delete_if{|x| x.waiting_list == true}.size.to_i <= 0
            return true
          else
            return false
          end
        else 
          return false
        end
      else 
        return false
      end

  end   
  
  def name_with_date
    self.title + (self.published != true ? ' (unpublished)' : " (#{self.published_at.strftime("%d.%m.%Y")})")
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
  
  def related_content
    related = []
    if event
      related << event
      unless event.posts.empty?
        related << event.posts.published.reject{|x| x == self}
      end
    end
    if project
      related << project
      unless project.posts.empty?
        related << project.posts.published.reject{|x| x == self }
        related << project.pages
      end
    end
    if festival
      related << festival
      unless festival.posts.empty?
        related << festival.posts.published.reject{|x| x == self }
      end
    end
    if residency
      related << residency
      unless residency.posts.empty?
        related << residency.posts.published.reject{|x| x == self }
      end
    end
    unless tags.empty?
    end
    related.flatten.uniq.delete_if{|x| x == self }.shuffle

  end
  
  def stream_date
    published_at.to_date
  end
  
  def endstream_date
    return nil
  end
  
  def title_en
    self.title(:en)
  end
  
  def title_present_in_at_least_one_locale
    if I18n.available_locales.map { |locale| translation_for(locale).title }.compact.empty?
      errors.add(:base, "You must specify a page title in at least one available language.")
    end
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
  
  def user_id
    creator_id
  end
  
  private
  
  def should_generate_new_friendly_id?
    changed?
  end
  
end
