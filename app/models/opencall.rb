class Opencall < ActiveRecord::Base
  belongs_to :subsite
  has_one :page
  validates_presence_of :name, :subsite_id
  has_many :opencallquestions, dependent: :destroy
  has_many :opencallsubmissions, dependent: :destroy
  accepts_nested_attributes_for :opencallquestions
  extend FriendlyId
  friendly_id :name , :use => [ :slugged, :finders ] # :history]
  translates :description, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations, reject_if: :all_blank
end
