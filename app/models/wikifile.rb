class Wikifile < ApplicationRecord
  include PublicActivity::Model
  tracked
  
  belongs_to :wikirevision
  mount_uploader :attachment, AttachmentUploader
  before_save :update_attachment_attributes



  def source_resource
    [:admin, wikirevision]
  end

  def source_name
    wikirevision.name
  end

  private

  def update_attachment_attributes
    if attachment.present? && attachment_changed?
      if attachment.file.exists?
        self.attachment = attachment.file.content_type
        self.attachment_size = attachment.file.size
      end
    end
  end
  
end
