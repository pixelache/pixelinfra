class AddBackgroundsToFrontitems < ActiveRecord::Migration
  def change
    add_column :frontitems, :background_on_title, :boolean, default: false, null: false
    add_column :frontitems, :background_on_text, :boolean, default: false, null: false
  end
end
