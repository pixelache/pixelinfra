class Projectproposal < ActiveRecord::Base
  belongs_to :project
  belongs_to :primary_initiator, :class_name => 'User'
  has_many :comments, as: :item, counter_cache: true
  has_paper_trail
  mount_uploader :budget, AttachmentUploader
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]
  validates_presence_of :name, :primary_initiator_id, :description
end
