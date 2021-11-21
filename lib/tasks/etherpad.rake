require 'etherpad-lite'

def survey_all_pads(server, api_key, archive = nil)
  existing_in_database = Etherpad.all.map(&:read_only_id)
  begin
    ether = EtherpadLite.connect(server, api_key)
    ether.pads.each do |pad|
      # TODO: this is very inefficient, refactor later
      if existing_in_database.include?(pad.read_only_id)
        updatetimestamp = Etherpad.find_by(read_only_id: pad.read_only_id)
        if updatetimestamp.last_edited != (Time.at(pad.last_edited / 1000).utc.to_datetime)
          updatetimestamp.last_edited = (Time.at(pad.last_edited / 1000).utc.to_datetime)
          updatetimestamp.save!
        end
        updatetimestamp.update_attribute(:archived, archive)
      else
        Etherpad.create(name: pad.name, read_only_id: pad.read_only_id,
                        archived: archive,
                        last_edited: Time.at(pad.last_edited / 1000).utc.to_datetime)
      end
    end
  rescue RestClient::Unauthorized
    return false
  end
end

namespace :etherpad do
  desc 'Synchronise etherpads with pixelache database'
  task sync_pads: :environment do
    survey_all_pads('http://pad.pixelache.ac', ENV['ETHERPAD_API_KEY'], false)
    survey_all_pads('http://pad.archive.pixelache.ac', ENV['ETHERPAD_ARCHIVE_KEY'], true)
  end
end
