class AddMaxAttendeesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :max_attendees, :integer
    add_column :events, :eventr_id, :integer
  end
end
