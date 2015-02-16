class AddHiddenToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :hidden, :boolean, null: false, default: false
  end
end
