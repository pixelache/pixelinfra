class Step < ActiveRecord::Base
  belongs_to :subsite
  belongs_to :festival
  belongs_to :node
  has_many :events
  translates :description, :fallbacks_for_empty_translations => true
  extend FriendlyId
  friendly_id :name , :use => [ :slugged, :finders, :scoped], :scope => :subsite
  resourcify
  
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['description'].blank? }
    
  attr_accessor  :event_name, :festival_name
  scope :by_subsite, -> subsite { where(subsite_id: subsite ) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  
  validates_presence_of :subsite_id, :number
  
  def event_name
    events.empty? ? nil : event.first.event_with_date
  end
  
  def festival_name
    festival.blank? ? nil : festival.name
  end
  
end
