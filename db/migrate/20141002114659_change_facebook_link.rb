class ChangeFacebookLink < ActiveRecord::Migration
  def change
    change_column :events, :facebook_link, :text
  end
end
