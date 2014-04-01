class AddPrivatepadToEtherpads < ActiveRecord::Migration
  def change
    add_column :etherpads, :private_pad, :boolean
  end
end
