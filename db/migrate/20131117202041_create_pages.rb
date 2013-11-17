class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.text :slug
      t.references :subsite
      t.boolean :published
      t.timestamps
    end
    Page.create_translation_table! :name => :string, :body => :text
  end
  
  def self.down
    drop_table :pages
    Page.drop_translation_table!
  end
end
