class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references :festivaltheme, index: true, foreign_key: true
      t.string :name
      t.string :phone
      t.text :description
      t.integer :experience_type
      t.string :location
      t.references :place, index: true, foreign_key: true
      t.boolean :approved
      t.boolean :other_activities
      t.text :special_instructions
      t.string :email
      t.string :when_text
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps null: false
    end
  end
end
