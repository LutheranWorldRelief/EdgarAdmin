# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  genre                  :string
#  birth_date             :date
#  state                  :boolean
#  uid                    :integer
#  ns                     :string
#  name                   :string
#  phone                  :bigint(8)
#  token                  :string
#  ts                     :integer          default(0)
#  country_id             :bigint(8)
#  chat_counter           :integer          default(0)
#  social_network         :string           default("null")
#  social_id              :string
#  age_time               :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
