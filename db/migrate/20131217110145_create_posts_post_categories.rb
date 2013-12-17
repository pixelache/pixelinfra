class CreatePostsPostCategories < ActiveRecord::Migration
  def change
    create_table :posts_post_categories, :id => false do |t|
      t.integer :post_id
      t.integer :post_category_id
    end
  end
end
