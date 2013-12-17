class AddWordpressIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :wordpress_id, :integer
    add_column :pages, :wordpress_author, :string
  end
end
