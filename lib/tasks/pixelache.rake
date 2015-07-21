namespace :pixelache do
  desc 'Get member feeds'
  task get_member_feeds: :environment do
    now = Time.now.to_i
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_OMNIAUTH_APP_ID']
      config.consumer_secret     = ENV['TWITTER_OMNIAUTH_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end  
    # build list of feeds
    twitters = User.pluck(:id, :twitter_name).delete_if{|x| x.last.blank? }
    
    # first get pixelache official twitter account
    pixelache = twitter_client.user_timeline("pixelache")
    pixelache.each do |tweet|
      Feedcache.where(source: 'twitter', official: true, issued_at: tweet.created_at.to_i, sourceid: tweet.id, title: tweet.text, content: tweet.text, link_url: tweet.uri.to_s).first_or_create
    end
    
    # now go through members
    twitters.each do |member_with_twitter|
      # check if they are a current member
      member = User.find(member_with_twitter.first)
      if member.current_member?
        begin
          twitter_client.user_timeline(member_with_twitter.last.gsub(/^@/, '')).each do |tweet|
            Feedcache.where(source: 'twitter', issued_at: tweet.created_at.to_i, official: false, user: member_with_twitter.first, sourceid: tweet.id, title: tweet.text, content: tweet.text, link_url: tweet.uri.to_s).first_or_create
          end
        rescue Twitter::Error::NotFound
          next
        end
      end
    end
  end
  
end