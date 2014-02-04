class AddExternalToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :external, :boolean, :null => false, :default => false
  end
end
