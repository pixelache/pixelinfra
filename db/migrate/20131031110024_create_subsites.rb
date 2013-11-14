class CreateSubsites < ActiveRecord::Migration
  def change
    create_table :subsites do |t|
      t.string :name
      t.string :description
      t.string :subdomain

      t.timestamps
    end
    create_sites 
  end
  
  def create_sites
    Subsite.create!(name: 'pixelache', description: 'Pixelache Helsinki', subdomain: 'www')
    Subsite.create!(name: 'olsof', description: 'Open Learning Steps and Open-Sourcing Festivals', subdomain: 'olsof')
  end
  
end
