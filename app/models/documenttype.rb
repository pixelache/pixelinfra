class Documenttype < ActiveRecord::Base
  acts_as_tree
  
  def evolvedto
    false
  end
end
