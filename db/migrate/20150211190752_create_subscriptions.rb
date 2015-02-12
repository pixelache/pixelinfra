class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.references :item, polymorphic: true, index: true
      t.string :member_id
      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :users
    add_column :projects, :has_listserv, :boolean, :null => false, default: false
    add_column :projects, :listservname, :string
    add_column :festivals, :has_listserv, :boolean, null: false, default: false
    add_column :festivals, :listservname, :string
  end
end
