class Opencall < ActiveRecord::Base
  belongs_to :subsite
  has_one :page
  validates_presence_of :name, :subsite_id
  has_many :opencallquestions
  has_many :opencallsubmissions
  accepts_nested_attributes_for :opencallquestions
  extend FriendlyId
  friendly_id :name , :use => [ :slugged, :finders ] # :history]
  
end
