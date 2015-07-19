class Experience < ActiveRecord::Base
  belongs_to :festivaltheme
  belongs_to :place
end
