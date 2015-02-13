module Listable
  extend ActiveSupport::Concern
  

  @@base_url = "http://#{ENV['PIXELACHE_MAILMAN_REST_USER']}:#{ENV['PIXELACHE_MAILMAN_REST_PASSWORD']}@#{ENV['PIXELACHE_MAILMAN_SERVER']}:#{ENV['PIXELACHE_MAILMAN_PORT']}/3.0"
  
  def check_listserv_support
    if self.has_listserv == true and self.has_listserv_changed?
      self.listservname = self.name.to_param if listservname.blank?
      check_if_list_exists
    end
  end
  
  
  def check_if_list_exists
    url = @@base_url + "/lists" 
    begin
      r = RestClient.get url + "/#{self.listservname}@#{ENV['PIXELACHE_MAILMAN_SERVER']}"
    rescue => e
      if e.response  == '404 Not Found'
        r = RestClient.post(url, { fqdn_listname: self.listservname + "@" + ENV['PIXELACHE_MAILMAN_SERVER']} )
        r = RestClient.put(url + "/#{self.listservname}@#{ENV['PIXELACHE_MAILMAN_SERVER']}/archivers", { prototype: "True", mhonarc: "False", :"mail-archive" => "False"})
      end
    end
  end
  
  def subscribe_to_list(user)

    begin
      r = RestClient.post(@@base_url + "/members", { list_id: listservname + "." + ENV['PIXELACHE_MAILMAN_SERVER'], subscriber: user.email, display_name: user.name })
    rescue => e
      if e.response == '"Member already subscribed"'
        # do nothing
      end
    end


    
    # get member id so we can unsubscribe
    begin
      r = RestClient.post(@@base_url + "/members/find", { list_id: listservname + "." + ENV['PIXELACHE_MAILMAN_SERVER'], subscriber: user.email })
      subscriptions.where(user: user).each {|x| x.destroy! }
      member_id = JSON.parse(r)['entries'].first['self_link'].match(/\d+$/)[0]
      subscriptions << Subscription.new(user: user, member_id: member_id)
    rescue
    end
  end
  
  def unsubscribe_from_list(user)
    bigid = subscriptions.find_by(user: user).member_id
    RestClient.delete(@@base_url + "/members/#{bigid}")
    subscriptions.find_by(user: user).destroy
  end
    
end