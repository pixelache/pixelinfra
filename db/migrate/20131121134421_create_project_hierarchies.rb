class CreateProjectHierarchies < ActiveRecord::Migration
  def change
    create_table :project_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... project
      t.integer  :descendant_id, :null => false # ID of the target project
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    # For "all progeny of…" and leaf selects:
    add_index :project_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "project_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :project_hierarchies, [:descendant_id],
      :name => "project_desc_idx"
  end
end
