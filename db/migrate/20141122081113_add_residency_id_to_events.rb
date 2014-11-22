class AddResidencyIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :residency_id, :integer, index: true
  end
end
