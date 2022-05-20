class CreateWikifiles < ActiveRecord::Migration[5.2]
  def change
    create_table :wikifiles do |t|
      t.references :wikirevision, foreign_key: true
      t.string :attachment
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.text :description
      t.timestamps
    end
  end
end
