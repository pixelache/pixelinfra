namespace :pixelache do

  desc 'move attachments'
  task move_attachments: :environment do
    require 'fileutils'
    Opencallanswer.all.each do |oca|
      opencall = oca.opencallquestion.opencall
      submission = oca.opencallsubmission

      if oca.attachment?
        next unless File.directory?("/Users/fail/Desktop/burn_attachments/#{oca.id.to_s}")
        puts 'Found directory ' + "/Users/fail/Desktop/burn_attachments/#{oca.id.to_s}"
        system 'mkdir', '-p', "/Users/fail/Desktop/burns/#{submission.id}-#{submission.name.parameterize}"
        Dir.foreach("/Users/fail/Desktop/burn_attachments/#{oca.id.to_s}") do |filename|
          next if filename == '.' or filename == '..'
          system 'cp', "/Users/fail/Desktop/burn_attachments/#{oca.id.to_s}/#{filename}", "/Users/fail/Desktop/burns/#{submission.id}-#{submission.name.parameterize}/"
        end
      end
    end
  end

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
    begin
      pixelache = twitter_client.user_timeline("pixelache")
      pixelache.each do |tweet|
        Feedcache.where(source: 'twitter', official: true, issued_at: tweet.created_at.to_i, sourceid: tweet.id, title: tweet.text, content: tweet.text, link_url: tweet.uri.to_s).first_or_create
      end
    
      # now go through members
      twitters.each do |member_with_twitter|
        # check if they are a current member
        member = User.find(member_with_twitter.first)
        if member.current_member?
          twitter_client.user_timeline(member_with_twitter.last.gsub(/^@/, '')).each do |tweet|
            Feedcache.where(source: 'twitter', issued_at: tweet.created_at.to_i, official: false, user: member_with_twitter.first, sourceid: tweet.id, title: tweet.text, content: tweet.text, link_url: tweet.uri.to_s).first_or_create
          end
        end
        
      end
    rescue Twitter::Error::ServiceUnavailable
      # do nothing here
    rescue Twitter::Error::NotFound
      # do nothing if twitter isn't connecting
    end  

  end
  
end