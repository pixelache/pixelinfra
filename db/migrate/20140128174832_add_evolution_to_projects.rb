class AddEvolutionToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :evolvedfrom_id, :integer
    add_column :projects, :evolution_year, :integer
  end
end
