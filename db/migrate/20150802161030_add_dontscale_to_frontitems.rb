class AddDontscaleToFrontitems < ActiveRecord::Migration
  def change
    add_column :frontitems, :dont_scale, :boolean
    add_column :frontitems, :no_text, :boolean
  end
end
