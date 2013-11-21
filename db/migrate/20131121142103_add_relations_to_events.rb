class AddRelationsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :project_id, :integer
    add_column :events, :festival_id, :integer
  end
end
