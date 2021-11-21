class Etherpad < ActiveRecord::Base
  has_and_belongs_to_many :subsites
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :festivals
  has_and_belongs_to_many :events
  has_and_belongs_to_many :meetings
  
  belongs_to :documenttype
  scope :by_festival, -> festival { joins(:festivals).where(["festivals.id = ?", festival]) }
  scope :by_subsite, -> subsite { joins(:subsites).where(["subsites.id = ?",  subsite]) }
  scope :by_project, -> project { joins(:projects).where(["projects.id = ?", project]) }
  scope :by_event, -> event { joins(:events).where(["events.id = ?", event]) }
  scope :by_meeting, -> meeting { joins(:meetings).where(["meetings.id = ?", meeting]) }  
  scope :by_documenttype, -> documenttype { where(documenttype_id: documenttype) }
  scope :not_private, -> { where("private_pad is not true")}
  scope :archived, ->(val) { where(archived: val) }
  
  
  attr_accessor :event_tokens
  
  def event_name
    events.empty? ? nil : events.map(&:event_with_date).join(', ')
  end
  
  def event_tokens=(ids)
    self.event_ids = ids.split(",")
  end

  def public_url
    "https://pad#{archived ? '.archive' : ''}.pixelache.ac/p/#{name}"
  end
  
end
