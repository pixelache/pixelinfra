class PostCategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name , :use => [ :slugged, :finders]
  has_and_belongs_to_many :posts
end
