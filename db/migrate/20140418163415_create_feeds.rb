class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :item_type
      t.references :item, index: true
      t.references :subsite, index: true
      t.datetime :fed_at
      t.string :action
      t.references :user, index: true

      t.timestamps
    end
    add_column :events, :user_id, :integer, null: false, default: 0
    
    [1,2].each do |site|
      Post.by_subsite(site).published.order('published_at DESC').limit(30).each do |post|
        post.add_to_feed('created')
      end
      Event.by_subsite(site).published.order('start_at DESC').limit(15).each do |event|
        event.add_to_feed('created')
      end
    end
  end
end
