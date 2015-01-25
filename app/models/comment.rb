class Comment < ActiveRecord::Base
  belongs_to :item, polymorphic: true
  belongs_to :user
  mount_uploader :image, ImageUploader
  mount_uploader :attachment, AttachmentUploader
  validates_presence_of :user_id, :item_id, :item_type, :content
  before_save :update_image_attributes, :update_attachment_attributes
  
  def update_image_attributes
    if image.present? && image_changed?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
  end
  
  def update_attachment_attributes
    if attachment.present? && attachment_changed?
      if attachment.file.exists?
        self.attachment_content_type = attachment.file.content_type
        self.attachment_size = attachment.file.size
      end
    end
  end

  
end
