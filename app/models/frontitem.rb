class Frontitem < ActiveRecord::Base
  belongs_to :frontmodule
  belongs_to :item, polymorphic: true
  belongs_to :subsite
  belongs_to :seconditem, polymorphic: true
  
  translates :custom_title, :custom_follow_text, :fallbacks_for_empty_translations => true
  validates_presence_of :subsite_id
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  attr_accessor  :item_name, :seconditem_name
  
  mount_uploader :bigimage, ArchiveimageUploader
  before_save :update_image_attributes
  
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['custom_title'].blank? && x['custom_follow_text'].blank? }
  
  
  def item_name
    item.try(:name)
  end
  
  def name
    if frontmodule
      if item
        if seconditem
          "<div class='module_title'>" + frontmodule.name + "</div><div class='module_content'>left: #{item.name}, right: #{seconditem.name}</div>"
        else
          "<div class='module_title'>" +  frontmodule.name + "</div><div class='module_content'>#{item.name}</div>"
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
    if bigimage.present? && bigimage_changed?
      if bigimage.file.exists?
        self.bigimage_content_type = bigimage.file.content_type
        self.bigimage_size = bigimage.file.size
        self.bigimage_width, self.bigimage_height = `identify -format "%wx%h" #{bigimage.file.path}`.split(/x/)
      end
    end
  end
  
end
