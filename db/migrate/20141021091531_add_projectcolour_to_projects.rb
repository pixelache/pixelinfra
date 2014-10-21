class AddProjectcolourToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_bg_colour, :string, :null => false, :default => 'f9ec31'
    add_column :projects, :project_text_colour, :string, :null => false, :default => '333'
    add_column :projects, :project_link_colour, :string, :null => false, :default => '008cba'
  end
end
