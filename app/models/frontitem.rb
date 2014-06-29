class Frontitem < ActiveRecord::Base
  belongs_to :frontmodule
  belongs_to :item, polymorphic: true
  belongs_to :subsite
  belongs_to :seconditem, polymorphic: true
  
  validates_presence_of :subsite_id
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  attr_accessor  :item_name, :seconditem_name
  
  mount_uploader :bigimage, ArchiveimageUploader
  before_save :update_image_attributes
  
  
  def item_name
    item.try(:name)
  end
  
  def name
    if frontmodule
      if item
        if seconditem
          frontmodule.name + " (left: #{item.name}, right: #{seconditem.name})"
        else
          frontmodule.name + " (#{item.name})"
        end
      else
        frontmodule.name
      end
    elsif !item.nil?
      item.class.to_s + ": " + item.name
    else
      "unknown"
    end
  end
  
  def seconditem_name
    seconditem.try(:name)
  end
  
  def update_image_attributes
    if bigimage.present?
      if bigimage.file.exists?
        self.bigimage_content_type = bigimage.file.content_type
        self.bigimage_size = bigimage.file.size
        self.bigimage_width, self.bigimage_height = `identify -format "%wx%h" #{bigimage.file.path}`.split(/x/)
      end
    end
  end
  
end
