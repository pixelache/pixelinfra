class AddUniquesToAuthentications < ActiveRecord::Migration
  def change
    add_index :authentications, [:user_id, :provider, :uid], unique: true
  end
end
