class AddItemToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :item_type, :string
    add_column :photos, :item_id, :integer
    add_index :photos, [:item_type, :item_id]
  end
end
