class CreateOpencallquestions < ActiveRecord::Migration
  def self.up
    create_table :opencallquestions do |t|
      t.references :opencall, index: true, foreign_key: true
      t.integer :question_type
      t.integer :sort_order
      t.integer :character_limit
      t.boolean :is_required, default: false, null: false
      t.timestamps null: false
    end
    Opencallquestion.create_translation_table! :question_text => :string
  end
  
  def self.down
    drop_table :opencallquestions
    Opencallquestion.drop_translation_table!
  end
  
end
