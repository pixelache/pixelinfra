class Archivalimage < ActiveRecord::Base
  belongs_to :event
  belongs_to :festival
  belongs_to :page
  belongs_to :project
  translates :caption
  
  mount_uploader :image, ArchiveimageUploader
end
