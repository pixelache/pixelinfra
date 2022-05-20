class Wikipage < ApplicationRecord
  has_many :wikirevisions
  include PublicActivity::Model
  tracked

  def name
    title
  end
end
