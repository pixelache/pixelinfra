class AddSubtitleToFestivals < ActiveRecord::Migration
  def up
    add_column :festivals, :subtitle, :string
    add_column :festivals, :image, :string
    add_column :festivals, :image_height, :integer
    add_column :festivals, :image_width, :integer
    add_column :festivals, :image_size, :integer
    add_column :festivals, :image_content_type, :string
    add_column :festivals, :background_colour, :string
    add_column :festivals, :primary_colour, :string
    Festival.create_translation_table! :overview_text => :text
  end
  
  def down
    drop_column :festivals, :subtitle
    drop_column :festivals, :image
    drop_column :festivals, :image_height
    drop_column :festivals, :image_width
    drop_column :festivals, :image_size
    drop_column :festivals, :image_content_type
    drop_column :festivals, :primary_colour
    drop_column :festivals, :background_colour
    Festival.drop_translation_table!
  end
    
end
