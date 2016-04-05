class Opencallsubmission < ActiveRecord::Base
  belongs_to :opencall
  has_many :opencallanswers

  accepts_nested_attributes_for :opencallanswers
end
