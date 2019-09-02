class AddFieldsToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :quarter_moon_cycle, :integer
    add_column :events, :description, :text
  end
end
