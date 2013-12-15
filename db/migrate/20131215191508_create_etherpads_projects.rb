class CreateEtherpadsProjects < ActiveRecord::Migration
  def change
    create_table :etherpads_projects, :id => false  do |t|
      t.integer :etherpad_id
      t.integer :project_id
    end
    create_table :etherpads_subsites, :id => false do |t|
      t.integer :etherpad_id
      t.integer :subsite_id
    end
  end
end
