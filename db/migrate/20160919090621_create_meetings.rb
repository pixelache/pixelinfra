class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.references :meetingtype, index: true, foreign_key: true

      t.timestamps null: false
    end
    create_table(:etherpads_meetings, id: false) do |t|
      t.integer :meeting_id
      t.integer :etherpad_id
    end
    Meeting.create_translation_table! name: :string  
  end
  
  def self.down
    Meeting.drop_translation_table!
    drop_table :meetings
    drop_table :etherpads_meetings
  end
end
