class Etherpad < ActiveRecord::Base
  has_and_belongs_to_many :subsites
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :festivals
  
  scope :by_festival, -> festival { joins(:festivals).where(["festivals.id = ?", festival]) }
  scope :by_subsite, -> subsite { joins(:subsites).where(["subsites.id = ?",  subsite]) }
  scope :by_project, -> project { joins(:projects).where(["projects.id = ?", project]) }
end
