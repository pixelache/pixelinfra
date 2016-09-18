class AddArchivedToProjectproposals < ActiveRecord::Migration
  def change
    add_column :projectproposals, :archived, :boolean, null: false, default: false
    add_column :projectproposals, :festival_id, :integer, index: true
    add_column :projectproposals, :event_id, :integer, index: true
  end
end
