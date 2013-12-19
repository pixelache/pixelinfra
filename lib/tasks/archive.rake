
namespace :archive do
  desc 'Synchronise flickr sets with pixelache database'
  task :sync_flickr_sets => :environment do
    existing_in_database = Flickrset.all.map{|x| [x.flickr_id, x.last_modified_date]}
    FlickRaw.api_key= ENV['FLICKR_API_KEY']
    FlickRaw.shared_secret= ENV['FLICKR_API_SECRET']
    flickr.photosets.getList(user_id: ENV['FLICKR_USER_ID']).each do |set|
      if existing_in_database.map(&:first).include?(set.id.to_i)
        # already exists so update timestamp if needed
        e = Flickrset.find_by(:flickr_id => set.id)
        if e.last_modified_date != Time.at(set.date_update.to_i).to_date
          e.last_modified_date = Time.at(set.date_update.to_i).to_date
          e.save
        end
      else
        Flickrset.create(:title => set.title, :description => set.description, :start_upload_date => Time.at(set.date_create.to_i).to_date, :last_modified_date => Time.at(set.date_update.to_i).to_date,       :flickr_id => set.id, :subsite_id => 1)
      end
    end
  end
  
end