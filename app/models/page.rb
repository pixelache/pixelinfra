class Page < ActiveRecord::Base
  belongs_to :subsite
  extend FriendlyId
  friendly_id :name_en, :use => [:history, :finders]
  has_paper_trail
  resourcify
  translates :name, :body, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['body'].blank? }

  validates_presence_of :subsite_id
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  
  def name_en
    self.name(:en)
  end
  
end
