class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.date :date_of_release
      t.references :subsite
      t.timestamps null: false
    end
    Document.create_translation_table! :title => :string, :description => :text
  end
  
  def self.down
    drop_table :documents
    Document.drop_translation_table!
  end
  
end
