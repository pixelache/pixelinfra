class AddEventrToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :eventr_id, :integer
  end
end
