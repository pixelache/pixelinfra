class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.string :name
      t.string :website
      t.string :city
      t.string :country
      t.string :slug
      t.string :logo
      t.string :logo_content_type
      t.integer :logo_height
      t.integer :logo_width
      t.integer :logo_size, :limit => 8

      t.timestamps
    end
    Node.create_translation_table! :description => :text
  end
  
  def self.down
    drop_table :nodes
    Node.drop_translation_table!
  end
  
end
