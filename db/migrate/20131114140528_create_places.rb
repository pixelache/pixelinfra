class CreatePlaces < ActiveRecord::Migration
  def up
    create_table :places do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :country
      t.string :postcode
      t.decimal :latitude, :precision => 10, :scale => 6
      t.decimal :longitude, :precision => 10, :scale => 6

      t.timestamps
    end
    Place.create_translation_table! :name => :string
  end
  
  def down
    drop_table :places
    Place.drop_translation_table!
  end
  
end
