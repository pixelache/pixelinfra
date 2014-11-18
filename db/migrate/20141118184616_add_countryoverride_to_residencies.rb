class AddCountryoverrideToResidencies < ActiveRecord::Migration
  def change
    add_column :residencies, :country_override, :string
  end
end
