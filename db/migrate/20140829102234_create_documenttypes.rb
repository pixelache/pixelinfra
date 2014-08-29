class CreateDocumenttypes < ActiveRecord::Migration
  def change
    create_table :documenttypes do |t|
      t.string :name
      t.integer :parent_id
      t.timestamps
    end
  end
end
