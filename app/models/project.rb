class Project < ActiveRecord::Base
  acts_as_tree
  has_and_belongs_to_many :etherpads
  has_many :events, :dependent => :nullify
  has_many :photos, as: :item
  has_many :attachments, as: :item
  translates :description
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['description'].blank? }
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }
  accepts_nested_attributes_for :attachments, :reject_if => proc {|x| x['attachedfile'].blank? }
  extend FriendlyId
  friendly_id :name , :use => [ :slugged, :finders ]
  has_paper_trail
  validates_presence_of :name
  validates_uniqueness_of :name
  belongs_to :evolvedfrom, :class_name => 'Project', :foreign_key => "evolvedfrom_id"
  has_one :evolvedto, :class_name  => 'Project', :foreign_key => "evolvedfrom_id"
end
