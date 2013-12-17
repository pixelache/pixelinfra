class CreatePostCategories < ActiveRecord::Migration
  def change
    create_table :post_categories do |t|
      t.string :name
      t.integer :wordpress_id
      t.string :slug

      t.timestamps
    end
  end
end
