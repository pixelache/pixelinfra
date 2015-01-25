class AddRedirecttoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :redirect_to, :string
  end
end
