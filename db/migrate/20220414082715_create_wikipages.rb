class CreateWikipages < ActiveRecord::Migration[5.2]
  def change
    create_table :wikipages do |t|
      t.string :title

      t.timestamps
    end
  end
end
