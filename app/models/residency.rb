class Residency < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  translates :description,  :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['description'].blank? }
  extend FriendlyId
  friendly_id :name, use: [:finders, :slugged]
  mount_uploader :photo, ImageUploader
  
  private
  
  def should_generate_new_friendly_id?
    name_changed?
  end
end
