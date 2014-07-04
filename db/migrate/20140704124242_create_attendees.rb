class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.references :user, index: true
      t.string :name
      t.text :description
      t.text :url
      t.string :email
      t.string :phone
      t.string :picture
      t.integer :picture_size, :length => 8
      t.string :picture_content_type
      t.integer :picture_width
      t.integer :picture_height
      t.boolean :status
      t.text :extra
      t.string :country
      t.string :attachment_url
      t.text :address
      t.string :organisation
      t.string :project_name
      t.text :project_description
      t.text :project_creators
      t.text :project_presenters
      t.text :project_urls
      t.text :motivation_statement
      t.string :project_title
      t.string :project_keyords
      t.references :event, index: true
      t.references :festival, index: true
      t.string :slug

      t.timestamps
    end
  end
end
