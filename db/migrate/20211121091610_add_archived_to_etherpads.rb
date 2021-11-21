class AddArchivedToEtherpads < ActiveRecord::Migration[5.2]
  def change
    add_column :etherpads, :archived, :boolean, null: false, default: false
    execute('UPDATE etherpads SET archived = true')
  end
end
