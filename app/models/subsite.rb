class Subsite < ActiveRecord::Base
  validates_presence_of :name, :description, :subdomain
  has_many :pages
  has_many :events
  has_many :posts
  has_and_belongs_to_many :nodes
end
