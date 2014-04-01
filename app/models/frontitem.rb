class Frontitem < ActiveRecord::Base
  belongs_to :frontmodule
  belongs_to :item, polymorphic: true
  belongs_to :subsite
  
  validates_presence_of :subsite_id
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  
  def name
    if frontmodule
      frontmodule.name
    elsif !item.nil?
      item.class.to_s + ": " + item.name
    else
      "unknown"
    end
  end
  
end
