class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :slug
      t.integer :parent_id
      t.timestamps
    end
    Project.create_translation_table! :description => :text
  end
  
  def self.down
    drop_table :projects
    Project.drop_translation_table!
  end
end
