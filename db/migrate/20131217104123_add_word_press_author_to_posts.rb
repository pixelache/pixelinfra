class AddWordPressAuthorToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :wordpress_author, :string
  end
end
