
class AddWordpressScopeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :wordpress_scope, :string
    add_column :photos, :wordpress_scope, :string
    add_column :pages, :wordpress_scope, :string
  end
end
