class AddChatCounterToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :chat_counter, :integer, default: 0
  end
end
