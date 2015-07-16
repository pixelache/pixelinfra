class Page < ActiveRecord::Base
  has_closure_tree :order => 'child_updated_at DESC'
  translates :name, :body, :fallbacks_for_empty_translations => true
  belongs_to :subsite
  belongs_to :festival
  belongs_to :project
  extend FriendlyId
  friendly_id :name_en, :use => [ :slugged, :finders, :scoped], :scope => :subsite
  has_paper_trail
  resourcify
  has_many :frontitems, as: :item, :dependent => :destroy
  has_many :festivalthemes,  through: :festivaltheme_relations
  has_many :festivaltheme_relations, as: :relation
  has_many :photos, as: :item
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['name'].blank? && x['body'].blank? }
  accepts_nested_attributes_for :photos, :reject_if => proc {|x| x['filename'].blank? }, :allow_destroy => true
  attr_accessor :festival_name, :project_name
  
  validates_presence_of :subsite_id
  
  after_save :update_root_timestamp
  
  scope :published, -> () { where(published: true) }
  scope :by_site, -> (x) { includes(:subsite).where(:subsite_id => x) }
  scope :festivals, ->  { where("festival_id is not null") }
  scope :by_subsite, -> (x) { where(subsite_id: x ) }
  scope :projects, ->  { where("project_id is not null") }
  scope :unlinked, ->  { where("project_id is null and festival_id is null")}
  scope :by_name, -> (name) { joins(:translations).where("page_translations.name ILIKE '%" + name + "%'")}
  
  
  def update_root_timestamp
    
    if self.root?
      update_column(:child_updated_at, Time.now)
    else
      
      parent.update_column(:child_updated_at, Time.now)
      root.update_column(:child_updated_at, Time.now)
    end
    update_column(:child_updated_at, Time.now)
  end
  
  def festival_name
    festival.blank? ? nil : festival.name
  end
  
  def has_project?
    !self_and_ancestors.map(&:project).compact.empty?
  end
  
  def headings
    Nokogiri::HTML(self.body).search('a[name]').map{|x| [x['name'], x.text] }.delete_if{|x| x.first.blank? }
  end
  
  def parent_project
    if has_project?
       self_and_ancestors.map(&:project).compact.first
    end
  end
  
  def name_en
    self.name(:en)
  end
  
  def project_name
    project.blank? ? nil : project.name
  end
  
  def title
    name
  end
end
