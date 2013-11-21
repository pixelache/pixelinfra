class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string :name
      t.date :start_at
      t.date :end_at
      t.string :website
      t.string :slug
      t.references :node

      t.timestamps
    end
  end
end
