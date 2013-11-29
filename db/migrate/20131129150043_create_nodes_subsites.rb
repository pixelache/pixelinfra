class CreateNodesSubsites < ActiveRecord::Migration
  def change
    create_table :nodes_subsites, :id => false do |t|
      t.integer :node_id
      t.integer :subsite_id
    end
  end
end
