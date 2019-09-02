class AddColorToCategoryEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :category_events, :color, :string
  end
end
