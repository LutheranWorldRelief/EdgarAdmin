class AddDefaultToEvent < ActiveRecord::Migration[5.2]
  def change
  	change_table :events do |t|
		  t.change :first_moon_cycle, :integer, default: 0
		  t.change :second_moon_cycle, :integer, default: 0
		  t.change :third_moon_cycle, :integer, default: 0
		  t.change :quarter_moon_cycle, :integer, default: 0
		end
  end
end
