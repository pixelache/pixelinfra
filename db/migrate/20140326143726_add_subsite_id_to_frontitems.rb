class AddSubsiteIdToFrontitems < ActiveRecord::Migration
  def change
    add_column :frontitems, :subsite_id, :integer
  end
end
