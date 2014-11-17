class CreateResidencies < ActiveRecord::Migration
  def self.up
    create_table :residencies do |t|
      t.string :name
      t.string :country
      t.date :start_at
      t.date :end_at
      t.boolean :is_micro
      t.string :photo
      t.integer :photo_size
      t.integer :photo_width
      t.integer :photo_height
      t.string :photo_content_type
      t.string :slug
      t.references :project, index: true
      t.references :user, index: true
      t.timestamps
    end
    Residency.create_translation_table! :description => :text
  end
  
  def self.down
    drop_table :residencies
    Residency.drop_translation_table!
  end
  
end
