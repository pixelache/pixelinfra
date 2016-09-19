class CreateMeetingtypes < ActiveRecord::Migration
  def self.up
    create_table :meetingtypes do |t|
      t.timestamps null: false
    end
    Meetingtype.create_translation_table! name: :string    
  end
  
  def self.down
    Meetingtype.drop_translation_table!
    drop_table :meetingtypes
  end
end
