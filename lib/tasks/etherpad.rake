require 'etherpad-lite'

namespace :etherpad do
  desc 'Synchronise etherpads with pixelache database'
  task :sync_pads => :environment do
    existing_in_database = Etherpad.all.map(&:read_only_id)
    ether = EtherpadLite.connect('http://pad.pixelache.ac', ENV['ETHERPAD_API_KEY'], '1.2.1')
    ether.pads.each do |pad|
      if existing_in_database.include?(pad.read_only_id)
        updatetimestamp = Etherpad.find_by(:read_only_id => pad.read_only_id)
        if updatetimestamp.last_edited != (Time.at(pad.last_edited / 1000).utc.to_datetime)
          updatetimestamp.last_edited = (Time.at(pad.last_edited / 1000).utc.to_datetime)
          updatetimestamp.save!
        end
      else
        Etherpad.create(:name => pad.name, :read_only_id => pad.read_only_id, :last_edited => Time.at(pad.last_edited / 1000).utc.to_datetime )
      end
    end
  end

end