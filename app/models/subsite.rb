class Subsite < ActiveRecord::Base
  validates_presence_of :name, :description, :subdomain
  has_many :pages
end
