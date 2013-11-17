class Place < ActiveRecord::Base
  translates :name, :fallbacks_for_empty_translations => true
  extend FriendlyId
  friendly_id :name_en, :use => [:finders, :history]
  geocoded_by :address
  after_validation :geocode, :on => :create
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? }

  
  def name_en
    self.name(:en)
  end

  def address
    [address1 , address2, city, country, postcode].delete_if {|x| x.blank? }.compact.join(', ')
  end
  
end
