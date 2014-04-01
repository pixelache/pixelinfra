class CreateArchivalimages < ActiveRecord::Migration
  def up
    create_table :archivalimages do |t|
      t.string :image
      t.integer :image_size
      t.integer :image_width
      t.integer :image_height
      t.string :image_content_type
      t.references :event, index: true
      t.references :festival, index: true
      t.references :page, index: true
      t.integer :flickr_id
      t.references :project, index: true
      t.string :credit
      t.timestamps
    end
    Archivalimage.create_translation_table! :caption => :string
  end
  
  def down
    drop_table :archivalimages
    Archivalimage.drop_translation_table!
  end
  
end
