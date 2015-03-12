class AddYearofpublicationToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :year_of_publication, :integer
  end
end
