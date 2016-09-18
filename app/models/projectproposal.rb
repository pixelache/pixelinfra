class Projectproposal < ActiveRecord::Base
  belongs_to :project
  belongs_to :festival
  belongs_to :event
  belongs_to :primary_initiator, :class_name => 'User'
  has_many :comments, as: :item, counter_cache: true, :dependent => :destroy
  has_paper_trail
  mount_uploader :budget, AttachmentUploader
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]
  validates_presence_of :name, :primary_initiator_id, :description
  after_create :notify_members
  belongs_to :offspring, class_name: 'Project'
  
  scope :archived, -> () { where(archived: true) }
  scope :current, -> () { where(archived: false) }

  private
  
  def notify_members
    ProjectproposalMailer.new_proposal(self).deliver rescue nil
  end
  
end
