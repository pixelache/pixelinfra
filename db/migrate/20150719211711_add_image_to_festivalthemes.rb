class AddImageToFestivalthemes < ActiveRecord::Migration
  def change
    add_column :festivalthemes, :image, :string
    add_column :festivalthemes, :image_file_size, :integer, limit: 8
    add_column :festivalthemes, :image_content_type, :string
    add_column :festivalthemes, :image_height, :integer
    add_column :festivalthemes, :image_width, :integer
  end
end
