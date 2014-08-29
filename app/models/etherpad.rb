class Etherpad < ActiveRecord::Base
  has_and_belongs_to_many :subsites
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :festivals
  has_and_belongs_to_many :events
  
  scope :by_festival, -> festival { joins(:festivals).where(["festivals.id = ?", festival]) }
  scope :by_subsite, -> subsite { joins(:subsites).where(["subsites.id = ?",  subsite]) }
  scope :by_project, -> project { joins(:projects).where(["projects.id = ?", project]) }
  scope :by_project, -> event { joins(:events).where(["events.id = ?", event]) }
  
  scope :not_private, -> { where("private_pad is not true")}
  
  attr_accessor :event_tokens
  
  def event_name
    events.empty? ? nil : events.map(&:event_with_date).join(', ')
  end
  
  def event_tokens=(ids)
    self.event_ids = ids.split(",")
  end
  
end
