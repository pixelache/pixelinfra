class AddEventIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :event_id, :integer
    add_column :posts, :project_id, :integer
    add_column :posts, :festival_id, :integer
  end
end
