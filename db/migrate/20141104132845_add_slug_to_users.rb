class AddSlugToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :slug, :string
    User.find_each(&:save)
  end
  
  def self.down
    remove_column :users, :slug
  end
end
