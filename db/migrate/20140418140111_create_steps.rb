class CreateSteps < ActiveRecord::Migration
  def up
    create_table :steps do |t|
      t.references :subsite, index: true
      t.references :festival, index: true
      t.references :node, index: true
      t.date :start_at
      t.date :end_at
      t.string :name
      t.integer :number
      t.references :event, index: true
      t.string :slug
      t.timestamps
    end
    Step.create_translation_table! :description => :text
  end
  
  def down
    drop_table :steps
    Step.drop_translation_table!
  end
end
