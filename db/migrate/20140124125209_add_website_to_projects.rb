class AddWebsiteToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :website, :string
  end
end
