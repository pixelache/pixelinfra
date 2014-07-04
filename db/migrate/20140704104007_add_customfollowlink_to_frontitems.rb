
class AddCustomfollowlinkToFrontitems < ActiveRecord::Migration
  def change
    add_column :frontitems, :custom_follow_text, :string, :null => false, :default => "Read more"
  end
end
