class AddBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :twitter_name, :string
    add_column :users, :feed_urls, :text
  end
end
