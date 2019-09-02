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

require 'test_helper'

class UserChatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
