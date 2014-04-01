class CreateDynamictaglines < ActiveRecord::Migration
  def change
    create_table :dynamictaglines do |t|
      t.references :subsite, index: true, unique: true, null: false
      t.text :festival
      t.text :electronic
      t.text :art
      t.text :subcultures

      t.timestamps
    end
  end
end
