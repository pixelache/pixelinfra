class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email,              :null => false, :default => ""
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
