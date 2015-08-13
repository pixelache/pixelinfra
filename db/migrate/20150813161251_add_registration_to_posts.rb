class AddRegistrationToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :registration_required, :boolean
    add_column :posts, :email_registrations_to, :string
    add_column :posts, :question_description, :string
    add_column :posts, :question_creators, :string
    add_column :posts, :question_motivation, :string
    add_column :posts, :email_template, :string
    add_column :posts, :max_attendees, :integer
  end
end
