class Project < ActiveRecord::Base
  acts_as_tree
  extend FriendlyId
  friendly_id :name , :use => [:finders,  :slugged, :history]
  has_paper_trail
  has_and_belongs_to_many :etherpads
 # translates :description
#  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['description'].blank? }
    
  validates_presence_of :name
  validates_uniqueness_of :name

end
