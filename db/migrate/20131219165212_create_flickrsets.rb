class CreateFlickrsets < ActiveRecord::Migration
  def self.up
    create_table :flickrsets do |t|
      t.integer :flickr_id, :limit => 8, :unique => true
      t.string :title
      t.text :description
      t.date :start_upload_date
      t.date :last_modified_date
      t.references :subsite, index: true, null: false
      t.references :event, index: true
      t.references :project, index: true
      t.references :festival, index: true

      t.timestamps
    end

    FlickRaw.api_key= ENV['FLICKR_API_KEY']
    FlickRaw.shared_secret= ENV['FLICKR_API_SECRET']
    flickr.photosets.getList(user_id: ENV['FLICKR_USER_ID']).each do |set|
      Flickrset.create(:title => set.title, :description => set.description, :start_upload_date => Time.at(set.date_create.to_i).to_date, :last_modified_date => Time.at(set.date_update.to_i).to_date,       :flickr_id => set.id, :subsite_id => 1)
    end
  end
  
  def self.down
    drop_table :flickrsets
  end
end
