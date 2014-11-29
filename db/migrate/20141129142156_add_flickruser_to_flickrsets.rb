class AddFlickruserToFlickrsets < ActiveRecord::Migration
  def change
    add_column :flickrsets, :flickr_user, :string, null: false, default: '91330886@N08'
  end
end
