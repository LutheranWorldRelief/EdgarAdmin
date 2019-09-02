class AddUsernameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :genre, :string
    add_column :users, :birth_date, :date
  end
end