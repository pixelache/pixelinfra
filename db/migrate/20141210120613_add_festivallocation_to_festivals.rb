class AddFestivallocationToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :festival_location, :string, null: false, default: 'Helsinki, Finland'
  end
end
