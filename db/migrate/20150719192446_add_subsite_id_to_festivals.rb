class AddSubsiteIdToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :subsite_id, :integer
    add_column :festivals, :redirect_to, :string
    add_index :festivals, :subsite_id
  end
end
