class Photo < ActiveRecord::Base
  mount_uploader :filename, ImageUploader
  before_save :update_image_attributes
  belongs_to :item, polymorphic: true
  

  scope :by_year, -> (x) { where(["image_date >= ? AND image_date <= ?", "#{x}-01-01", "#{x}-12-31"])}
  
  def update_image_attributes
    if filename.present? && filename_changed?
      if filename.file.exists?
        self.filename_content_type = filename.file.content_type
        self.filename_size = filename.file.size
        self.filename_width, self.filename_height = `identify -format "%wx%h" #{filename.file.path}`.split(/x/)
      end
    end

    if self.item.class == Post 
      self.image_date = self.item.published_at.to_date if self.item.published == true
    elsif self.item.class == Event
      self.image_date = self.item.start_at.to_date
    end

    
  end
end
