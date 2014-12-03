class CreateFestivalthemes < ActiveRecord::Migration
  def self.up
    create_table :festivalthemes do |t|
      t.references :festival, index: true
      t.timestamps
    end
    Festivaltheme.create_translation_table! :name => :string, :description => :text
    add_column :events, :festivaltheme_id, :integer, index: true
  end
  
  def self.down
    drop_table :festivalthemes
    Festivaltheme.drop_translation_table!
  end
  
end
