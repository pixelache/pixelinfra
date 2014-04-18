class AddStepToEvents < ActiveRecord::Migration
  def change
    add_column :events, :step_id, :integer
  end
end
