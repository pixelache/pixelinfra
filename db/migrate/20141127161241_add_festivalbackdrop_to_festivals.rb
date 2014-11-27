class AddFestivalbackdropToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :festivalbackdrop, :string
  end
end
