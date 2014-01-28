class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :attachedfile
      t.string :attachedfile_content_type
      t.integer :attachedfile_size, :limit => 8
      t.string :item_type
      t.integer :item_id
      t.string :title
      t.text :description
      t.boolean :public
      t.timestamps
    end
    add_index :attachments, [:item_type, :item_id]
  end
end
