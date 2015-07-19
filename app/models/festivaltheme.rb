class Festivaltheme < ActiveRecord::Base
  belongs_to :festival
  translates :name, :description, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations, reject_if: proc {|x| x['name'].blank? }
  has_many :events, through: :festivaltheme_relations, source_type: 'Event', source: :relation, foreign_key: :relation_id
  has_many :pages, through: :festivaltheme_relations, source_type: 'Page', source: :relation  
  has_many :festivaltheme_relations
  mount_uploader :image, ImageUploader
  before_save :update_image_attributes
  validates_presence_of :festival_id
  
  extend FriendlyId
  friendly_id :name_en, use: [:slugged, :finders, :scoped], :scope => :festival
  
  def name_and_festival
    [name, festival.name].join(' / ')
  end
  
  def name_en
    self.name(:en)
  end
  
  def update_image_attributes
    if image.present? && image_changed?
      if image.file.exists?
        self.image_content_type = image.file.content_type
        self.image_file_size = image.file.size
        self.image_width, self.image_height = `identify -format "%wx%h" #{image.file.path}`.split(/x/)
      end
    end
  end
  
end
