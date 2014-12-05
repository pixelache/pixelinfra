class AddSlugToFestivalthemes < ActiveRecord::Migration
  def change
    add_column :festivalthemes, :slug, :string
    Festivaltheme.find_each(&:save)
  end
end
