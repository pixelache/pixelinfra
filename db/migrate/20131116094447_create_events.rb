class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.references :subsite, index: true
      t.references :place, index: true
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :published
      t.string :image
      t.integer :image_width
      t.integer :image_height
      t.string :image_content_type
      t.integer :image_size, :limit => 8
      t.integer :facebook_link, :limit => 8
      t.float :cost
      t.float :cost_alternate
      t.string :cost_alternate_reason

      t.timestamps
    end
    Event.create_translation_table! :name => :string, :description => :text, :notes => :text
  end
  
  def self.down
    drop_table :events
    Event.drop_translation_table!
  end
end
