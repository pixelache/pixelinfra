class AddRawhtmlToFrontitems < ActiveRecord::Migration[5.1]
  def change
    add_column :frontitems, :rawhtml, :text
  end
end
