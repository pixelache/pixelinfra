class ContributorRelation < ActiveRecord::Base
  belongs_to :contributor
  belongs_to :relation, polymorphic: true
  validates :contributor, presence: true
  validates :relation_id, presence: true, uniqueness: { scope: %i[relation_type contributor_id] }
end
