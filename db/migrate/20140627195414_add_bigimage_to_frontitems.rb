class AddBigimageToFrontitems < ActiveRecord::Migration
  def change
    add_column :frontitems, :bigimage, :string
    add_column :frontitems, :bigimage_size, :integer, :length => 8
    add_column :frontitems, :bigimage_width, :integer
    add_column :frontitems, :bigimage_height, :integer
    add_column :frontitems, :bigimage_content_type, :string
  end
end
