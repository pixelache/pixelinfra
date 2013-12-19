class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :hostid
      t.string :thumbnail
      t.integer :thumbnail_size, :limit => 8
      t.integer :thumbnail_width
      t.integer :thumbnail_height
      t.string :thumbnail_content_type
      t.references :event, index: true
      t.references :project, index: true
      t.references :festival, index: true
      t.integer :video_width
      t.integer :video_height
      t.integer :duration
      t.boolean :published

      t.timestamps
    end
  end
end
