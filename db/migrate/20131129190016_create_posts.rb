class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :slug
      t.references :subsite, index: true
      t.boolean :published
      t.integer :creator_id, index: true
      t.integer :last_modified_id, index: true
      t.datetime :published_at
      t.integer :wordpress_id
      t.string :image
      t.integer :image_width
      t.integer :image_height
      t.string :image_content_type
      t.integer :image_size, :limit => 8
      t.timestamps
    end
    Post.create_translation_table! :title => :string, :body => :text, :excerpt => :text
  end
  
  def self.down
    drop_table :posts
    Post.drop_translation_table!
  end
end
