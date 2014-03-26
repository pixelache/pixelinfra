class CreateFrontitems < ActiveRecord::Migration
  def change
    create_table :frontitems do |t|
      t.string :item_type
      t.integer :item_id
      t.integer :position
      t.string :external_url
      t.string :background_colour
      t.string :text_colour
      t.boolean :active
      t.integer :frontmodule_id

      t.timestamps
    end
  end
end
