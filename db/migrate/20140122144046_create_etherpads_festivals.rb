class CreateEtherpadsFestivals < ActiveRecord::Migration
  def change
    create_table :etherpads_festivals, :id => false do |t|
      t.references :etherpad, index: true, null: false
      t.references :festival, index: true, null: false
    end

  end
end
