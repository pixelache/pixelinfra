class FestivalthemeRelation < ActiveRecord::Base
  
  belongs_to :festivaltheme
  belongs_to :relation, polymorphic: true

end