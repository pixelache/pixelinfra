class CreateOpencalls < ActiveRecord::Migration
  def change
    create_table :opencalls do |t|
      t.references :subsite, index: true, foreign_key: true
      t.boolean :published
      t.boolean :is_open
      t.references :page, index: true, foreign_key: true
      t.text :submitted_text
      t.string :name
      t.timestamps null: false
    end
  end
end
