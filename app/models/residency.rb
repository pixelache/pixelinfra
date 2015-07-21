class Residency < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :posts
  has_many :events
  translates :description,  :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations, :reject_if => proc {|x| x['description'].blank? }
  extend FriendlyId
  friendly_id :name, use: [:finders, :slugged]
  mount_uploader :photo, ImageUploader
  validates_presence_of :start_at, :name
  
  scope :micro, -> { where(is_micro: true) }
  scope :production, -> { where("is_micro is not true")}
  
  def related_content
    out = []
    # out << project if project
    out << posts.published
    out << events.published
    out.unshift project if project
    out.flatten.compact.uniq
  end
  
  def body
    description
  end
  
  def feed_time
    start_at
  end
  
  private
  
  def should_generate_new_friendly_id?
    name_changed?
  end
end
