class Node < ActiveRecord::Base
  translates :description
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['description'].blank? }
  validates_presence_of :name
  mount_uploader :logo, ImageUploader
  extend FriendlyId
  friendly_id :name, :use => :finders
  before_save :update_image_attributes
  
  def update_image_attributes
    if logo.present?
      self.logo_content_type = logo.file.content_type
      self.logo_size = logo.file.size
      self.logo_width, self.logo_height = `identify -format "%wx%h" #{logo.file.path}`.split(/x/)
      # if you also need to store the original filename:
      # self.original_filename = image.file.filename
    end
  end
  
end
