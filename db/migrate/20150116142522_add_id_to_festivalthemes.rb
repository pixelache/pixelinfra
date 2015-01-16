class AddIdToFestivalthemes < ActiveRecord::Migration
  def self.up
    add_column :festivaltheme_relations, :id, :primary_key
  end
  
  def self.down
    remove_column :festivaltheme_relations, :id
  end
end
