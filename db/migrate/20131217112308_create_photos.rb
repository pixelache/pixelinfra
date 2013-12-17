class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :filename
      t.integer :filename_width
      t.integer :filename_height
      t.string :filename_content_type
      t.integer :filename_size, :limit => 8
      t.integer :wordpress_id
      t.timestamps
    end
  end
end
