class AddTertiarycolorToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :tertiary_colour, :string, null: false, default: 'FFFFFF'
  end
end
