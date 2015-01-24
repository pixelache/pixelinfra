# encoding: utf-8

class ArchiveimageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :aws

  def store_dir
      "#{Rails.env.to_s}/images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  version :standard do
    versions[:twelve]
  end
  
  version :full do
    process :resize_to_fit => [1920, 1080]
  end

  version :twelve do
    process :resize_to_fit => [1200, 600]
  end

  version :halfwidth do
    process :resize_to_fill => [600, 600]
  end

  version :thumb do
    process :resize_to_fill => [100, 100]
  end

end
