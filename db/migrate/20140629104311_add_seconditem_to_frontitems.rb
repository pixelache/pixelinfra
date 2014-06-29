class AddSeconditemToFrontitems < ActiveRecord::Migration
  def change
    add_column :frontitems, :seconditem_type, :string
    add_column :frontitems, :seconditem_id, :string
    add_index :frontitems, [:seconditem_id, :seconditem_type]
    add_index :frontitems, [:item_id, :item_type]
  end
end
