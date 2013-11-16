class Event < ActiveRecord::Base
  belongs_to :subsite
  belongs_to :place
  translates :name, :description, :notes, :fallbacks_for_empty_translations => true
  extend FriendlyId
  friendly_id :name_en, :use => :history
  
  def name_en
    self.name(:en)
  end
  
  
end
