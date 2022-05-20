class CreateWikirevisions < ActiveRecord::Migration[5.2]
  def change
    create_table :wikirevisions do |t|
      t.references :user, foreign_key: true
      t.text :contents
      t.references :wikipage, foreign_key: true

      t.timestamps
    end
  end
end
