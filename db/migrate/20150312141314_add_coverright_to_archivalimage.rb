class AddCoverrightToArchivalimage < ActiveRecord::Migration
  def change
    add_column :archivalimages, :cover_right, :boolean, null: false, default: false
  end
end
