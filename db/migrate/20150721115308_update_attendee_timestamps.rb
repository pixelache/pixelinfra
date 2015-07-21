class UpdateAttendeeTimestamps < ActiveRecord::Migration
  def change
    Attendee.where(created_at: nil).each do |att|
      att.update_column(:created_at, att.item.feed_time)
    end
  end

end
