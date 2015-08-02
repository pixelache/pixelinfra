class AddTitleToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :title, :string
    add_column :experiences, :latitude, :float, precision:10, scale: 6
    add_column :experiences, :longitude, :float, precision:10, scale: 6
  end
end
