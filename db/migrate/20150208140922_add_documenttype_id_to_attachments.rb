class AddDocumenttypeIdToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :documenttype_id, :integer
    add_index :attachments, :documenttype_id
  end
end
