class AddFakeEmailToUser < ActiveRecord::Migration[5.2]
  def change
	add_column :users, :another_email, :string
  end
end
