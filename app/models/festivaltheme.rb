class Festivaltheme < ActiveRecord::Base
  belongs_to :festival
  translates :name, :description, :short_description, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations, reject_if: proc {|x| x['name'].blank? }
  has_many :festivaltheme_relations
  has_many :events, through: :festivaltheme_relations, source_type: 'Event', source: :relation, foreign_key: :relation_id
  has_many :pages, through: :festivaltheme_relations, source_type: 'Page', source: :relation  
  has_many :posts, through: :festivaltheme_relations, source_type: 'Post', source: :relation, foreign_key: :relation_id
  
  mount_uploader :image, ImageUploader
  before_save :update_image_attributes
  validates_presence_of :festival_id
  has_many :experiences
  
  extend FriendlyId
  friendly_id :name_en, use: [:slugged, :finders, :scoped], :scope => :festival
  
  def name_and_festival
    [name, festival.name].join(' / ')
  end
  

  def as_json(options = {})
    { id: self.id, name: self.name, festival_id: self.festival_id, name_and_festival: self.name_and_festival }    
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
