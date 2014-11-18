class AddResidencyIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :residency_id, :integer, index: true
  end
end
