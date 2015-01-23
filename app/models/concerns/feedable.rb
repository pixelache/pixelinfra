module Feedable
  extend ActiveSupport::Concern
  
  def add_to_feed(action = 'created')
    Feed.create(:action => action, :subsite_id => self.subsite_id, :user_id => self.user_id, :item_id => self.id, :item_type => self.class.to_s, :fed_at => self.feed_time)
  end
  
  def check_for_feed
    unless self.hide_from_feed == true || self.published != true
      self.feed.destroy
      add_to_feed
    end
  end
  
end