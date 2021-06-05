class Contributor < ActiveRecord::Base
  JSON_RELATIONS = [:festivalthemes, :contributor_relations]
  has_closure_tree
  mount_uploader :image, ImageUploader
  extend FriendlyId
  friendly_id :name, :use => [ :slugged, :finders ] # :history]

  belongs_to :user, optional: true
  has_many :attachments, as: :item, dependent: :destroy
  has_many :festivaltheme_relations, as: :relation, foreign_key: :relation_id, dependent: :destroy
  has_many :festivalthemes,  through: :festivaltheme_relations
  has_many :contributor_relations, dependent: :destroy
  has_many :events, through: :contributor_relations, source_type: 'Event', source: :relation#, foreign_key: :relation_id
  has_many :festivals, through: :contributor_relations, source_type: 'Festival', source: :relation#, foreign_key: :relation_id
  has_many :residencies, through: :contributor_relations, source_type: 'Residency', source: :relation#, foreign_key: :relation_id
  has_many :projects, through: :contributor_relations, source: :relation, source_type: 'Project'
  accepts_nested_attributes_for :projects,  allow_destroy: true
  accepts_nested_attributes_for :festivals,  allow_destroy: true
  accepts_nested_attributes_for :residencies,  allow_destroy: true
  accepts_nested_attributes_for :events,  allow_destroy: true
  accepts_nested_attributes_for :festivalthemes,  allow_destroy: true
  accepts_nested_attributes_for :attachments, :reject_if => proc {|x| x['attachedfile'].blank? }, :allow_destroy => true

  validates :name, presence: true, uniqueness: true
  validates :alphabetical_name, presence: true

  before_save :update_image_attributes

  def activities_list
    contributor_relations.map{|x| x.relation.respond_to?(:name) ? x.relation.name : x.relation_type }
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
