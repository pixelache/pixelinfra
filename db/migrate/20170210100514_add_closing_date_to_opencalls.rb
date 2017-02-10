class AddClosingDateToOpencalls < ActiveRecord::Migration[5.0]
  def change
    add_column :opencalls, :closing_date, :datetime
  end
end
