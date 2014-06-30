class Page < ActiveRecord::Base
  acts_as_tree
  translates :name, :body, :fallbacks_for_empty_translations => true
  belongs_to :subsite
  belongs_to :festival
  belongs_to :project
  extend FriendlyId
  friendly_id :name_en, :use => [ :slugged, :finders, :scoped], :scope => :subsite
  has_paper_trail
  resourcify
  
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['body'].blank? }

  attr_accessor :festival_name, :project_name
  
  validates_presence_of :subsite_id
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  
  def festival_name
    festival.blank? ? nil : festival.name
  end
  
  
  def name_en
    self.name(:en)
  end
  
  def project_name
    project.blank? ? nil : project.name
  end
  
  def title
    name
  end
end
