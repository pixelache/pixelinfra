
class AddRegistrationrequiredToEvents < ActiveRecord::Migration
  def change
    add_column :events, :registration_required, :boolean
    add_column :events, :email_registrations_to, :string
    add_column :events, :question_description, :string
    add_column :events, :question_creators, :string
    add_column :events, :question_motivation, :string
    add_column :events, :require_approval, :boolean
    add_column :events, :hide_registrants, :boolean
    add_column :events, :show_guests_to_public, :boolean
  end
end
