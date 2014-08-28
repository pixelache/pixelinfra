class CreateEtherpadsEvents < ActiveRecord::Migration
  def change
    create_table :etherpads_events, :id => false do |t|
      t.references :etherpad, index: true, null: false
      t.references :event, index: true, null: false
    end
  end
end
