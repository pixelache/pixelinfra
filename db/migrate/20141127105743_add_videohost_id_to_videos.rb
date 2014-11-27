class AddVideohostIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :videohost_id, :integer, null: false, index: true
  end
end
