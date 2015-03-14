@cache_dir = 'lib/assets/'
@scope = '2007'

# rake acts_as_taggable_on_engine:install:migrations
# rake db:migrate
# rake wordpress:posts
# rake wordpress:attachments
# rake wordpress:associate_secondary_images
# rake wordpress:convert_line_breaks

# class Oldattendee < ActiveRecord::Base
#   establish_connection(
#     :adapter  => "mysql2",
#     :host     => "localhost",
#     :wait_timeout => 0.5,
#     :username => "root",
#     :password => ENV['old_mysql_password'],
#     :database => "newpixelache"
#   )
#   self.table_name =  :pixelache_eventr_attendee
# end
#
# class Oldattendeejoin < ActiveRecord::Base
#   establish_connection(
#     :adapter  => "mysql2",
#     :host     => "localhost",
#     :wait_timeout => 0.5,
#     :username => "root",
#     :password => ENV['old_mysql_password'],
#     :database => "newpixelache"
#   )
#   self.table_name =  "pixelache_eventr_event_attendee"
# end


def hash_from_cache
  xml = @cache_dir + 'pixelache2005.xml'
  cache = @cache_dir + 'pixelache2005.cache.rb'

  if ! File.exists?(cache)
    data = File.read xml
    hash = Hash.from_xml data
    File.open(cache, "wb") {|io| Marshal.dump(hash, io)}
  else
    hash = File.open(cache, "rb") {|io| Marshal.load(io)}
  end
end

# --------------------------------------------------------------------
# post methods

def get_tagged_posts(hash)
  hash['rss']['channel']['item'].select do |item|
    categories = item['category']
    if categories.class == String
      categories = [categories]
    end
    ['Aside','Main'].each do |ignore|
      if index = categories.index(ignore)
        categories.delete_at index
      end
    end
    categories.length > 1
  end
end

def get_thumbnail_image(post)

  # look for thumbnail if exists
  thumb = 0
  if post['postmeta'].class != Hash && !post['postmeta'].nil?
    post['postmeta'].each do |h|
      if h["meta_key"] == "_thumbnail_id"
        thumb = h["meta_value"]
      end
    end
  end
  if thumb != 0
    master_image = Photo.find_by(:wordpress_id => thumb)
    unless master_image.nil? 
      master_image.id
    end
  end
end  

def get_formated_content(post)
  content = post['encoded'].first

  # remove comments
  comment_regex = /([<!\-\-].*?[\-\-]\s*>)/
  content.gsub!(comment_regex, '')

  # convert caption blocks to real HTML
  caption_regex = /\[caption .*\](?<image><(a|strong|img)(.*)>)(?<caption>(.*))\[\/caption\]/
  caption_replace = '<figure>\k<image><figcaption>\k<caption></figcaption></figure>'
  content.gsub!(caption_regex,caption_replace)

  image_regex = /^(?<image>(<(a |strong)(.*)>)?<img (.*)\/>(<\/(a|strong)>)?)/
  image_replace = '<figure>\k<image></figure>'
  content.gsub!(image_regex,image_replace)

  content
end

def get_formatted_excerpt(post)
  content = post['encoded'].last
  unless content.blank?
    # TODO
    # convert first photo to Model
    # wrap with <p>'s

    # remove comments
    comment_regex = /([<!\-\-].*?[\-\-]\s*>)/
    content.gsub!(comment_regex, '')

    # convert caption blocks to real HTML
    caption_regex = /\[caption .*\](?<image><(a|strong|img)(.*)>)(?<caption>(.*))\[\/caption\]/
    caption_replace = '<figure>\k<image><figcaption>\k<caption></figcaption></figure>'
    content.gsub!(caption_regex,caption_replace)

    image_regex = /^(?<image>(<(a |strong)(.*)>)?<img (.*)\/>(<\/(a|strong)>)?)/
    image_replace = '<figure>\k<image></figure>'
    content.gsub!(image_regex,image_replace)
  end
  content
end


def get_photo(post)
  first_photo_regex = /<img.+src=['"]([^'"]+)['"].*>/
  post['encoded'][0][first_photo_regex, 1]
end

def get_tags(post)
  tags = post['category']
  if tags.class == String
    tags = [tags]
  end
  # remove useless tags
  ['Aside','Main'].each do |ignore|
    if index = tags.index(ignore)
      tags.delete_at index
    end
  end
  # convert 'foo + bar' into seperate tags
  tags.collect! do |tag|
    bits = tag.split ' + '
    tag = bits.shift
    bits.each { |b| tags.push b }
    tag
  end
  # tags.push('wp-import')
end

# --------------------------------------------------------------------
# author methods

def get_authors(hash)
  hash['rss']['channel']['author']
end

def generate_password(len=10)
  o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
  (0...len).map{ o[rand(o.length)] }.join
end

# --------------------------------------------------------------------

namespace :wordpress do

  task :cache => :environment do
    hash = hash_from_cache

    # write authors to cache
    # authors = get_authors(hash)
    # cache = @cache_dir + 'authors.cache.rb'
    # File.open(cache, "wb") { |io| Marshal.dump(authors, io) }

    # write posts to cache
    posts = get_tagged_posts(hash)
    cache = @cache_dir + 'posts.cache.rb'
    File.open(cache, "wb") { |io| Marshal.dump(posts, io) }
  end

  task :categories => :environment do
    xml = @cache_dir + 'pixelache2005.xml'
    data = File.read xml
    hash = Hash.from_xml data
    hash['rss']['channel']['category'].each do |c|
      PostCategory.create(:name => c['cat_name'], :slug => c['category_nicename'], :wordpress_id => c['term_id'])
    end
  end
  
  task :attachments => :environment do
    xml = @cache_dir + 'pixelache2005.xml'
    data = File.read xml
    hash = Hash.from_xml data
    hash['rss']['channel']['item'].each do |i|
      next unless i['post_type'] == 'attachment'
      unless i['attachment_url'].blank?
        if Photo.find_by(:wordpress_id => i['post_id'], :wordpress_scope => @scope)
          puts "already found with wordpress id #{i['post_id']}"
        else
          Photo.create(:remote_filename_url => i['attachment_url'], :wordpress_id => i['post_id'], :wordpress_scope => @scope ) rescue next
        end
      end
    end
  end    

  task :map_page_tree => :environment do 
    xml = @cache_dir + 'pixelache2005.xml'
    data = File.read xml
    hash = Hash.from_xml data
    hash['rss']['channel']['item'].each do |p|
      next unless p['post_type'] == 'page'
      next if p['post_parent'] == "0"
      # get page in new database
      new_db = Page.find_by(:wordpress_id => p['post_id'], :wordpress_scope => @scope)
      new_db.parent = Page.find_by(:wordpress_id => p['post_parent'], :wordpress_scope => @scope)
      new_db.save
    end
  end
  
  task :pages => :environment do
    xml = @cache_dir + 'pixelache2005.xml'
    data = File.read xml
    hash = Hash.from_xml data
    hash['rss']['channel']['item'].each do |p|
      next unless p['post_type'] == 'page'   
      page = Page.create(
        name: p['title'],
        subsite_id: 1,
        published: p['status'] == 'draft' ? false : true,
        body: get_formated_content(p),
        wordpress_id: p['post_id'],
        wordpress_author: p['post_creator'],
        wordpress_scope: @scope,
        created_at: p['pubDate'],
        updated_at: p['pubDate'], 
        slug: p['post_name']
        
      )
    end
  end
  
  task :associate_secondary_images => :environment do 
    xml = @cache_dir + 'pixelache2005.xml'
    data = File.read xml
    hash = Hash.from_xml data
    
    # to be run after importing attachments and posts, so primary images should be
    # deleted from the photos table, leaving only secondary images
    hash['rss']['channel']['item'].each do |i|
      next unless i['post_type'] == 'attachment'

      # get entry in photo table
      photo_entry = Photo.find_by(:wordpress_id => i['post_id'])
      next if photo_entry.nil?  # we deleted it as it's a primary image post
      # check for existence of parent post
      parent_post = Post.find_by(:wordpress_id => i['post_parent'])
      next if parent_post.nil?
      if parent_post.photos.include?(photo_entry)
        # it's already here so don't put it twice
        next
      else
        parent_post.photos << photo_entry
        parent_post.save!
      end

    end
  end 
  
  task :posts => :environment do
    xml = @cache_dir + 'pixelache2005.xml'
    data = File.read xml
    hash = Hash.from_xml data
    cats = PostCategory.all.map{|x| [x.name, x.id] }
    Post.paper_trail_off!
    hash['rss']['channel']['item'].each do |p|
      next unless p['post_type'] == 'post'
      next unless Post.find_by(:wordpress_id => p['post_id']).nil?
      # author = User.find_by_username(p['creator'])
      article = Post.create(
        title: p['title'],
        body: get_formated_content(p),
        excerpt: get_formatted_excerpt(p),
        published_at: p['pubDate'],
        wordpress_id: p['post_id'],
        wordpress_author: p['creator'],
        wordpress_scope: @scope,
        subsite_id: 1, 
        published: p['status'] == 'draft' ? false : true,
        tag_list: get_tags(p)
      )
      ti = get_thumbnail_image(p)
      if ti
        photo = Photo.find(ti)
        article.remote_image_url = photo.filename.url
        photo.destroy
      end
      article.post_category_ids =  p['category'].blank? ? false : ( p['category'].class == Array ? p['category'].map{|x| cats.find{|y| y.first == x }.last } : [cats.find{|y| y.first == p['category']}.last] ) rescue []
      article.save(validate: false)
    end
  end
  
  task :migrate_event_registrations => :environment do
    ActiveRecord::Base.record_timestamps = false
    
    begin
      Post.where('eventr_id is not null').each do |post|
        puts 'Attendees for post ' + post.name
        Oldattendeejoin.where(:event_ID => post.eventr_id).each do |ea|
          oa = Oldattendee.find(ea.attendee_ID)
          # puts oa.inspect
          Attendee.create(:name => oa.name, :description => oa.description, :url => oa.url,  :extra => oa.extra, :country => oa.country, :address => oa.address, :status => oa.status, :project_name => oa.project_name, :project_description => oa.project_description, :project_creators => oa.project_creators, :project_presenters => oa.project_presenters, :project_urls => oa.project_urls, :motivation_statement => oa.motivation_statement, :project_title => oa.project_title, :project_keywords => oa.project_keywords, :item_id => post.id, :item_type => 'Post')
        end
      end
      Festival.where('eventr_id is not null').each do |fest|
        puts 'Attendees for festival ' + fest.name
        Oldattendeejoin.where(:event_ID => fest.eventr_id).each do |ea|
          oa = Oldattendee.find(ea.attendee_ID)
          # puts oa.inspect
          Attendee.create(:name => oa.name, :description => oa.description, :url => oa.url,  :extra => oa.extra, :country => oa.country, :address => oa.address, :status => oa.status, :project_name => oa.project_name, :project_description => oa.project_description, :project_creators => oa.project_creators, :project_presenters => oa.project_presenters, :project_urls => oa.project_urls, :motivation_statement => oa.motivation_statement, :project_title => oa.project_title, :project_keywords => oa.project_keywords, :item_id => fest.id, :item_type => 'Festival')
        end
      end
      Event.where('eventr_id is not null').each do |event|
        puts 'Attendees for event ' + event.name
        Oldattendeejoin.where(:event_ID => event.eventr_id).each do |ea|
          oa = Oldattendee.find(ea.attendee_ID)
          # puts oa.inspect
          Attendee.create(:name => oa.name, :description => oa.description, :url => oa.url,  :extra => oa.extra, :country => oa.country, :address => oa.address, :status => oa.status, :project_name => oa.project_name, :project_description => oa.project_description, :project_creators => oa.project_creators, :project_presenters => oa.project_presenters, :project_urls => oa.project_urls, :motivation_statement => oa.motivation_statement, :project_title => oa.project_title, :project_keywords => oa.project_keywords, :item_id => event.id, :item_type => 'Event')
        end
      end            
      
    rescue => e
      puts e
    end
  end
  

  task migrate_images: :environment do
    ActiveRecord::Base.record_timestamps = false
    Post::Translation.all.each do |post|
      next if post.body.nil?
      matches = post.body.scan(/['"]((https?):\/\/(www\.:?)pixelache\.ac\/wp-content[^"]+)/).map(&:first).uniq
      matches.each do |image_url|
        # check to see if it's already in our database
        existing = Ckeditor::Asset.find_by(wordpress_url: image_url)
        
        # new record so grab url and save and mark if missing
        if existing.nil?
          ck = Ckeditor.picture_model.new
          
          # if it ends in something like -660x371 try to get original
          if image_url =~ /\-\d\d\dx\d\d\d\.(jpe?g|png|gif)$/
            first_try = image_url.gsub(/\-\d\d\dx\d\d\d\./, '.')
            ck.remote_data_url = first_try
            ck.wordpress_url = image_url
            if !ck.save
              ck.remote_data_url = image_url
            end
          else
            ck.remote_data_url = image_url
          end
          
          ck.wordpress_url = image_url
          begin
            ck.save!
          rescue ActiveRecord::RecordInvalid
              ck.remote_data_url = 'http://www.pixelache.ac/helsinki/wp-content/uploads/2010/02/pixelache-1.gif'
              ck.missing = true
              ck.save!
          end
          existing = ck
        end
          
        # already exists so just replace with correct URL  
        post.body.gsub!(image_url, existing.data.url)
        if existing.missing
          puts "broken URL: #{image_url}"
        else
          puts "replaced #{image_url} with #{existing.data.url} for Post ##{post.post_id}"
        end
        # doc = Nokogiri::HTML.fragment(post.body)
        # doc.search('figure').each do |a|
        #   a.replace(a.content)
        # end
        # post.body = doc.to_html
        post.body.gsub!(/<\/?figure>/, '')
        
        post.save(validate: false)
      end  # end of matches.each loop
      unless post.globalized_model.image? || matches.empty?
        d = Ckeditor::Asset.find_by(wordpress_url: matches.first)
        unless d.missing == true
          post.globalized_model.remote_image_url = d.data.url
          post.globalized_model.save!
          puts "Post ##{post.post_id} was missing image, now has #{d.data.url}"
        end
      end
         
    end
  end
  
      

  task :convert_page_line_breaks => :environment do
    ActiveRecord::Base.record_timestamps = false
    begin
      Page.where(:wordpress_scope => @scope).each do |p|
        next if p.body.nil?
        p.body = p.body.gsub(/(?:\n\r?|\r\n?)/, '<br />')
        p.save! rescue p.id
      end
    ensure
      ActiveRecord::Base.record_timestamps = true
    end
  end
  
  task :convert_line_breaks => :environment do
    ActiveRecord::Base.record_timestamps = false
    begin
      Post.where(:wordpress_scope => @scope).each do |p|
        next if p.body.nil?
        p.body = p.body.gsub(/(?:\n\r?|\r\n?)/, '<br>')
        p.save! rescue p.id
      end
    ensure
      ActiveRecord::Base.record_timestamps = true
    end
  end
end