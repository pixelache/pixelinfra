class Festivaltheme < ActiveRecord::Base
  belongs_to :festival
  translates :name, :description, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations, reject_if: proc {|x| x['name'].blank? }
  has_many :events, through: :festivaltheme_relations, source_type: 'Event', source: :relation, foreign_key: :relation_id
  has_many :pages, through: :festivaltheme_relations, source_type: 'Page', source: :relation  
  has_many :festivaltheme_relations

  validates_presence_of :festival_id
  
  extend FriendlyId
  friendly_id :name_en, use: [:slugged, :finders, :scoped], :scope => :festival
  
  def name_and_festival
    [name, festival.name].join(' / ')
  end
  
  def name_en
    self.name(:en)
  end
  
end
