class Opencallanswer < ActiveRecord::Base
  belongs_to :opencallsubmission
  belongs_to :opencallquestion
  mount_uploader :attachment, AttachmentUploader
end
