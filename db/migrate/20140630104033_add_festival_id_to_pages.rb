class AddFestivalIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :festival_id, :integer
    add_column :pages, :project_id, :integer
    add_index :pages, :project_id
    add_index :pages, :festival_id
  end
end
