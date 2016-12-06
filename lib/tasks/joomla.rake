#
# class Oldpost < ActiveRecord::Base
#   establish_connection(
#     :adapter  => "mysql2",
#     :host     => "localhost",
#     :wait_timeout => 0.5,
#     :username => "root",
#     :password => ENV['old_mysql_password'],
#     :database => "university"
#   )
#   self.table_name =  :pa08_content
#
# end
#
# class Olduser < ActiveRecord::Base
#   establish_connection(
#     :adapter  => "mysql2",
#     :host     => "localhost",
#     :wait_timeout => 0.5,
#     :username => "root",
#     :password => ENV['old_mysql_password'],
#     :database => "university"
#   )
#   self.table_name =  :pa08_users
#
# end
#
#
# namespace :joomla do
#
#   task :get_pages => :environment do
#     festival = Page.create(name: 'Pixelache 2008 Festival', subsite_id: 1, festival: Festival.find('festival-2008'))
#     university = Project.create(name: 'Pixelache University 2008')
#
#
#     Oldpost.where(catid: 0).each do |page|
#       next if page.state == -2
#       if page.sectionid == 1
#         Page.create(name: page.title, body: page.introtext + page.fulltext, published: page.state, wordpress_id: page.id, wordpress_author: Olduser.find(page.created_by).email, subsite_id: 1, created_at: page.created, wordpress_scope: page.version, sort_order: page.ordering, project: university)
#       else
#         Page.create(name: page.title, body: page.introtext + page.fulltext, published: page.state, wordpress_id: page.id, wordpress_author: Olduser.find(page.created_by).email, subsite_id: 1, created_at: page.created, wordpress_scope: page.version, sort_order: page.ordering, parent_id: festival.id)
#       end
#     end
#     Oldpost.where(catid: 4).each do |page|
#       next if page.state == -2
#       Page.create(name: page.title, body: page.introtext + page.fulltext, published: page.state, wordpress_id: page.id, wordpress_author: Olduser.find(page.created_by).email, subsite_id: 1, created_at: page.created, wordpress_scope: page.version, sort_order: page.ordering, parent_id: festival.id)
#     end
#   end
#
#
#   task :get_events => :environment do
#     # university events
#     university = Project.find('pixelache-university-2008')
#     festival = Festival.find('festival-2008')
#
#     Oldpost.where(catid: 1).each do |page|
#
#       Event.create(name: page.title, description: page.introtext + page.fulltext, published: page.state, subsite_id: 1, start_at: page.created, created_at: page.created, project: university, place_id: 72)
#
#     end
#
#     Oldpost.where("catid >= 5 and catid <=8").each do |page|
#       puts page.title
#       e = Event.create(name: page.title, description: page.introtext + page.fulltext, published: page.state, subsite_id: 1, start_at: page.created, created_at: page.created, festival: festival, place_id: 72 )
#
#     end
#   end
#
#   task :get_posts => :environment do
#     # blog posts
#     Oldpost.where(catid: 2).each do |page|
#       p = Post.create(title: page.title, body: page.introtext + page.fulltext, published: page.state, wordpress_id: page.id, wordpress_author: Olduser.find(page.created_by).email, subsite_id: 1, created_at: page.created, wordpress_scope: page.version, published_at: page.state == 0 ? nil : page.created)
#       puts p.errors.full_messages
#     end
#   end
#
# end
#
#
#