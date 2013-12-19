class Video < ActiveRecord::Base
  belongs_to :event
  belongs_to :project
  belongs_to :festival
end
