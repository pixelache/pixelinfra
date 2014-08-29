class CreateDocumenttypeHierarchies < ActiveRecord::Migration
  def change
    create_table :documenttype_hierarchies, :id => false  do |t|
      t.integer :ancestor_id, :null => false 
      t.integer :descendant_id, :null => false 
      t.integer :generations, :null => false 
    end 
    add_index :documenttype_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "documenttype_anc_desc_udx"

   
    add_index :documenttype_hierarchies, [:descendant_id],
      :name => "documenttype_desc_idx"
      
  end
end
