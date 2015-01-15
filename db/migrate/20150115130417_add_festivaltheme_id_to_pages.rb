class AddFestivalthemeIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :festivaltheme_id, :integer
  end
end
