class AddStartToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :start, :datetime
    add_column :events, :end, :datetime
  end
end
