class Documenttype < ActiveRecord::Base
  acts_as_tree
  has_many :attachments
  
  def evolvedto
    false
  end
end
