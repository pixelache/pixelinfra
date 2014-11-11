class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user, index: true
      t.string :year
      t.boolean :paid
      t.boolean :hallitus
      t.boolean :hallitus_alternate
      t.string :notes
      t.timestamps
    end
    
    add_index :memberships, [:user_id, :year], unique: true
    
  end
end
