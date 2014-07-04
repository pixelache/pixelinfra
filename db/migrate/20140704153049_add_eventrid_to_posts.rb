class AddEventridToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :eventr_id, :integer
  end
end
