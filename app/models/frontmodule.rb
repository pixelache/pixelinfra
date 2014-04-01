class Frontmodule < ActiveRecord::Base
  has_many :frontitems
  mount_uploader :exampleimage, ImageUploader
end
