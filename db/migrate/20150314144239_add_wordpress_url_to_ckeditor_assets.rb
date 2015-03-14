class AddWordpressUrlToCkeditorAssets < ActiveRecord::Migration
  def change
    add_column :ckeditor_assets, :wordpress_url, :string, unique: true
    add_column :ckeditor_assets, :missing, :boolean, default: false, null: false
  end
end
