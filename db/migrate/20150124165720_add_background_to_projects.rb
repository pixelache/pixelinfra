class AddBackgroundToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :background, :string
    add_column :projects, :background_file_size, :integer, limit: 8
    add_column :projects, :background_content_type, :string
    add_column :projects, :background_height, :integer
    add_column :projects, :background_width, :integer
  end
end
