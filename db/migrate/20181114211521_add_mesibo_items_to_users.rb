class AddMesiboItemsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :integer
    add_column :users, :ns, :string
    add_column :users, :name, :string
    add_column :users, :phone, :bigint
    add_column :users, :token, :string
    add_column :users, :ts, :integer, default: 0
  end
end