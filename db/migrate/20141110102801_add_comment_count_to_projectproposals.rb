class AddCommentCountToProjectproposals < ActiveRecord::Migration
  def change
    add_column :projectproposals, :comment_count, :integer, default: 0
    Projectproposal.reset_column_information
     Projectproposal.all.each do |p|
       Projectproposal.update_counters p.id, :comment_count => p.comments.length
     end
  end
end
