class AddSlugToOpencalls < ActiveRecord::Migration
  def change
    add_column :opencalls, :slug, :string
  end
end
