class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :item, polymorphic: true, index: true
      t.references :user, index: true
      t.text :content
      t.string :image
      t.integer :image_width
      t.string :image_content_type
      t.integer :image_size, length: 8
      t.integer :image_height
      t.string :attachment
      t.integer :attachment_size, length: 8
      t.string :attachment_content_type

      t.timestamps
    end
  end
end
