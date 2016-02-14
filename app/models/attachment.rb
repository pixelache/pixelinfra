class Attachment < ActiveRecord::Base
  belongs_to :item, polymorphic: true
  mount_uploader :attachedfile, AttachmentUploader
  validates_presence_of :attachedfile
  before_save :get_metadata
  belongs_to :documenttype
  
  scope :public_files, ->() { where(public: true) }
  def get_metadata
    if attachedfile.present?  && attachedfile_changed?
      if attachedfile.file.exists?
        self.attachedfile_content_type = attachedfile.file.content_type
        self.attachedfile_size = attachedfile.file.size
      end
    end
  end
end
