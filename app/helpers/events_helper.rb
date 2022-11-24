module EventsHelper
  def cache_key_for_events
    count          = Event.count
    max_updated_at = Event.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "events/all-#{count}-#{max_updated_at}"
  end
end