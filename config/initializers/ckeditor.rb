# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default), :mongo_mapper and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require "ckeditor/orm/active_record"
  # config.assets_plugins = ['image2']
  # config.assets_languages = ['en', 'fi']
  config.cdn_url = "//cdn.ckeditor.com/4.16.1/standard/ckeditor.js"
  # Allowed image file types for upload.
  # Set to nil or [] (empty array) for all file types
  # config.image_file_types = ["jpg", "jpeg", "png", "gif", "tiff"]

  # Allowed attachment file types for upload.
  # Set to nil or [] (empty array) for all file types
  # config.attachment_file_types = ["doc", "docx", "xls", "odt", "ods", "pdf", "rar", "zip", "tar", "swf"]

  # Setup authorization to be run as a before filter
  # config.authorize_with :cancan
end
