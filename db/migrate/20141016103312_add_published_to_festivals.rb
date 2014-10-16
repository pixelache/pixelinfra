class AddPublishedToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :published, :boolean, :default => false
    execute('UPDATE festivals SET published = true')
    change_column :festivals, :published, :boolean, :null => false
  end
end
