class Project < ActiveRecord::Base
  acts_as_tree
  has_and_belongs_to_many :etherpads
  has_many :events, :dependent => :nullify
  has_many :photos, as: :item
  has_many :pages
  has_many :posts
  has_many :videos
  has_many :attachments, as: :item
  translates :description, :short_description
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['description'].blank? && x['short_description'].blank? }
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :attachments, :reject_if => proc {|x| x['attachedfile'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :videos , reject_if: proc {|x| x['in_url'].blank? }, :allow_destroy => true
  extend FriendlyId
  friendly_id :name , :use => [ :slugged, :finders ]
  has_paper_trail
  validates_presence_of :name
  validates_uniqueness_of :name
  belongs_to :evolvedfrom, :class_name => 'Project', :foreign_key => "evolvedfrom_id"
  has_one :evolvedto, :class_name  => 'Project', :foreign_key => "evolvedfrom_id"
  mount_uploader :background, AttachmentUploader 
  scope :active, -> { where(active: true)}
  scope :inactive, -> { where(active: false)}
  has_many :subscriptions, as: :item
  before_save :check_listserv_support
  include Listable
  has_one :projectproposal, foreign_key: 'offspring_id'
  
  def self.active_menu
    a = Project.active.sort_by{|x| x.name }.map{|x| [x.name, x.id]}
    i = Project.inactive.sort_by{|x| x.name }.map{|x| [x.name, x.id]}
    return a + [' -- inactive/old projects -- '] + i
  end 
    
  def background_css
    "background-color: ##{project_bg_colour}; color: ##{project_text_colour}; "
  end
  
  def background_image_css
    if background.url.nil?
      ""
    else
      "background: url(#{background.url.gsub(/development/, 'production')}) no-repeat right top; background-size: cover; background-color:  ##{project_bg_colour}"
    end
  end
  
  def colour_offset
    "#{project_bg_colour.match(/(..)(..)(..)/).to_a[1..3].map{|x| [[0, x.hex + ( x.hex * -0.15)].max, 255].min }.map{|x| x.to_i.to_s }.join(', ')}"
  end
  
  def to_hashtag
    "##{name.gsub(/\s*/, '')}"
  end
   
end
