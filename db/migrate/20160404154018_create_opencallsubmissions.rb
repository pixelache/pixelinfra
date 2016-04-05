class CreateOpencallsubmissions < ActiveRecord::Migration
  def change
    create_table :opencallsubmissions do |t|
      t.references :opencall, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :postcode
      t.string :country
      t.string :website

      t.timestamps null: false
    end
  end
end
