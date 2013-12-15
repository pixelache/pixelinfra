class CreateEtherpads < ActiveRecord::Migration
  def change
    create_table :etherpads do |t|
      t.string :name
      t.string :read_only_id, unique: true
      t.boolean :deleted, :null => false, :default => false
      t.datetime :last_edited
      t.timestamps
    end
  end
end
