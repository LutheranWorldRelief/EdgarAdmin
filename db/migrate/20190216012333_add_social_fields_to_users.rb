class AddSocialFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
	add_column :users, :social_network, :string, default: :null
	add_column :users, :social_id, :integer, default: :null
  end
end
