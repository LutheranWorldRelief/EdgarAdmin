class AddAgeTimeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age_time, :integer
  end
end
