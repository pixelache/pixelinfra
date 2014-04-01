class AddExampleimageToFrontmodules < ActiveRecord::Migration
  def change
    add_column :frontmodules, :exampleimage, :string
  end
end
