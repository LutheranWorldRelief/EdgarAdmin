class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.integer :first_moon_cycle
      t.integer :second_moon_cycle
      t.integer :third_moon_cycle
      t.text :article
      t.boolean :status

      t.timestamps
    end
  end
end
