class AddOsfFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :resources_needed, :text
    add_column :events, :protocol, :text
  end
end
