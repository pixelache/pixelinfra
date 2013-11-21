class AddFacilitatorsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :facilitator_name, :string
    add_column :events, :facilitator_url, :string
    add_column :events, :facilitator_organisation, :string
    add_column :events, :facilitator_organisation_url, :string
  end
end
