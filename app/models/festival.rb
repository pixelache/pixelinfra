class Festival < ActiveRecord::Base
  belongs_to :node
  has_many :events
  has_and_belongs_to_many :etherpads
  # has_many :projects
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]
  has_event_calendar
  validates_presence_of :name, :node_id

  def happens_on?(day)
    if end_at.blank?
      return true if day.to_date == start_at.to_date
    else
      return true if day.to_date >= start_at.to_date && day.to_date <= end_at.to_date
    end
  end
    
end
