class AddWaitinglistToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :waiting_list, :boolean
  end
end
