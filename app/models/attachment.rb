class Attachment < ActiveRecord::Base
  belongs_to :item, polymorphic: true
  mount_uploader :attachedfile, AttachmentUploader
  before_save :get_metadata
  
  def get_metadata
    if attachedfile.present?
      self.attachedfile_content_type = attachedfile.file.content_type
      self.attachedfile_size = attachedfile.file.size
    end
  end
end
