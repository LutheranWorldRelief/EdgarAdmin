class ChangeSocialIdType < ActiveRecord::Migration[5.2]
  def change
	change_column :users, :social_id, :string
  end
end
