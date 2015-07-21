class AddLocationtbdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location_tbd, :boolean
  end
end
