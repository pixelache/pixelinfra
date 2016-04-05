class AddAttachmentToOpencallanswer < ActiveRecord::Migration
  def change
    add_column :opencallanswers, :attachment, :string
  end
end
