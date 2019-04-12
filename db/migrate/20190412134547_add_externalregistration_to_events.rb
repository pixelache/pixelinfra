class AddExternalregistrationToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :external_registration, :string
  end
end
