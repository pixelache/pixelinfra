class Page < ActiveRecord::Base
  acts_as_tree
  translates :name, :body, :fallbacks_for_empty_translations => true
  belongs_to :subsite
  extend FriendlyId
  friendly_id :name_en, :use => [ :slugged, :finders, :scoped], :scope => :subsite
  has_paper_trail
  resourcify
  
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['body'].blank? }

  validates_presence_of :subsite_id
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  
  def name_en
    self.name(:en)
  end
  
  def title
    name
  end
end
