class AddConstraintsToFrontitems < ActiveRecord::Migration
  def change
    change_column :frontitems, :background_colour, :string, :null => false, :default => "f05a28"
    change_column :frontitems, :text_colour, :string, :null => false, :default => "FFFFFF"
  end

end
