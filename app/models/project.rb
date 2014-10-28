class Project < ActiveRecord::Base
  acts_as_tree
  has_and_belongs_to_many :etherpads
  has_many :events, :dependent => :nullify
  has_many :photos, as: :item
  has_many :pages
  has_many :posts
  has_many :attachments, as: :item
  translates :description
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['description'].blank? }
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :attachments, :reject_if => proc {|x| x['attachedfile'].blank? }, :allow_destroy => true
  extend FriendlyId
  friendly_id :name , :use => [ :slugged, :finders ]
  has_paper_trail
  validates_presence_of :name
  validates_uniqueness_of :name
  belongs_to :evolvedfrom, :class_name => 'Project', :foreign_key => "evolvedfrom_id"
  has_one :evolvedto, :class_name  => 'Project', :foreign_key => "evolvedfrom_id"
  
  def background_css
    if photos.empty?
      ""
    else
      "background: url(#{photos.first.filename.url}) no-repeat center top; background-size: cover; background-color: white"
    end
  end
end
