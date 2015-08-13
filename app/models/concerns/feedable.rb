module Feedable
  extend ActiveSupport::Concern
  
  def add_to_feed(action = 'created')
    Feed.create(:action => action, :subsite_id => self.subsite_id, :user_id => self.user_id, :item_id => self.id, :item_type => self.class.to_s, :fed_at => self.feed_time)
  end
  
  def delete_feeds
    self.feeds.delete_all
  end
  
  def check_for_feed
    self.feeds.delete_all
    if self.add_to_newsfeed == "1" || self.published == true      
      self.add_to_feed
    end
  end
  
end