# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :aws
  
  def default_url
    '/assets/potato.png'
  end
  
  def store_dir
    "avatars/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fill => [100, 100]
  end
  
  version :box do
    process :resize_to_fill => [400, 400]
  end
  
  
end
