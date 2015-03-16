class CreateFeedcaches < ActiveRecord::Migration
  def change
    create_table :feedcaches do |t|
      t.string :source
      t.string :title
      t.string :link_url
      t.text :content
      t.references :user, index: true
      t.boolean :hidden
      t.integer :issued_at, length: 8, null: false
      t.string :sourceid, null: false
      t.boolean :official, default: false, null: false
      t.boolean :hashtag, default: false, null: false
      t.timestamps null: false
    end
    add_foreign_key :feedcaches, :users
    add_index :feedcaches, [:sourceid, :source], unique: true
  end
end
