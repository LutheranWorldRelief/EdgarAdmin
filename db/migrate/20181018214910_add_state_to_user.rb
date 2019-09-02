class AddStateToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :state, :boolean
  end
end
