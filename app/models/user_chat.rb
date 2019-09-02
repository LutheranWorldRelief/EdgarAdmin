# == Schema Information
#
# Table name: user_chats
#
#  id             :bigint(8)        not null, primary key
#  user_technical :integer
#  user_producer  :integer
#  url_chat       :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class UserChat < ApplicationRecord
end
