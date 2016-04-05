class AddOpencallToPages < ActiveRecord::Migration
  def change
    add_column :pages, :opencall_id, :integer
  end
end
