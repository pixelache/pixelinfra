class AddOffspringIdToProjectproposals < ActiveRecord::Migration
  def change
    add_column :projectproposals, :offspring_id, :integer
  end
end
