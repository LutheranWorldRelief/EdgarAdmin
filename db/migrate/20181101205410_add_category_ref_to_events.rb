class AddCategoryRefToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :category_event, foreign_key: true
  end
end
