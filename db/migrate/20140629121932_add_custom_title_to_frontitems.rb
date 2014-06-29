class AddCustomTitleToFrontitems < ActiveRecord::Migration
  def change
    add_column :frontitems, :custom_title, :string
  end
end
