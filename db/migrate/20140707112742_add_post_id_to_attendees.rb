class AddPostIdToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :item_id, :integer
    add_column :attendees, :item_type, :string
    rename_column :attendees, :project_keyords, :project_keywords
  end
end
