class AddSortOrderToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sort_order, :integer
  end
end
