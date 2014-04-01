class Dynamictagline < ActiveRecord::Base
  belongs_to :subsite
  validates_presence_of :subsite_id
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  
  def tagline
    [festival, electronic, art, subcultures].any? {|x| x.blank? } ? "Festival of Electronic Art and Subcultures" :  festival.split(',').sample + " of " + electronic.split(',').sample + " " + art.split(',').sample + "  " + ["and", "and", "or", "or", "and", "and", "and", "and", "and/or", "and/or"].sample + " " + subcultures.split(',').sample
  end
  
end
