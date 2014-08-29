class AddDocumenttypeIdToEtherpads < ActiveRecord::Migration
  def change
    add_column :etherpads, :documenttype_id, :integer
  end
end
