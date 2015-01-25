class Photo < ActiveRecord::Base
  mount_uploader :filename, ImageUploader
  before_save :update_image_attributes
  belongs_to :item, polymorphic: true
  
  def update_image_attributes
    if filename.present? && filename_changed?
      if filename.file.exists?
        self.filename_content_type = filename.file.content_type
        self.filename_size = filename.file.size
        self.filename_width, self.filename_height = `identify -format "%wx%h" #{filename.file.path}`.split(/x/)
      end
    end
  end

end
