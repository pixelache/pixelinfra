class Feedcache < ActiveRecord::Base
  belongs_to :user
  
  def feed_origin
    if user_id.nil?
      "Pixelache"
    else
      user
    end
  end
end
