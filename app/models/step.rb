class Step < ActiveRecord::Base
  belongs_to :subsite
  belongs_to :festival
  belongs_to :node
  belongs_to :event
  translates :description, :fallbacks_for_empty_translations => true
  extend FriendlyId
  friendly_id :name , :use => [ :slugged, :finders, :scoped], :scope => :subsite
  resourcify
  
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['title'].blank? && x['body'].blank? }
    
  attr_accessor  :event_name, :festival_name
  scope :by_subsite, -> subsite { where(subsite_id: subsite ) }
  
  def event_name
    event.blank? ? nil : event.event_with_date
  end
  
  def festival_name
    festival.blank? ? nil : festival.name
  end
  
end
