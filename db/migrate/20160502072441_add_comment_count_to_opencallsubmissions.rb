class AddCommentCountToOpencallsubmissions < ActiveRecord::Migration
  def change
    add_column :opencallsubmissions, :comment_count, :integer, default: 0
  end
end
