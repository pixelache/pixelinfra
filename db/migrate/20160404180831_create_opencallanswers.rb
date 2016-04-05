class CreateOpencallanswers < ActiveRecord::Migration
  def change
    create_table :opencallanswers do |t|
      t.references :opencallsubmission, index: true, foreign_key: true
      t.references :opencallquestion, index: true, foreign_key: true
      t.text :answer
      t.string :attachment_file_name
      t.integer :attachment_file_size
      t.string :attachment_content_type

      t.timestamps null: false
    end
    add_index :opencallanswers, [:opencallsubmission_id, :opencallquestion_id], :unique => true, :name => 'ocqs_index'
  end
end
