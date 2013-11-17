class AddSlugToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :slug, :string
    add_column :events, :slug, :string
  end
end
