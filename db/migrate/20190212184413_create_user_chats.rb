class CreateUserChats < ActiveRecord::Migration[5.2]
  def change
    create_table :user_chats do |t|
      t.integer :user_technical
      t.integer :user_producer
      t.text :url_chat

      t.timestamps
    end
  end
end
