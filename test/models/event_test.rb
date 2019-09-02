# == Schema Information
#
# Table name: events
#
#  id                 :bigint(8)        not null, primary key
#  title              :string
#  first_moon_cycle   :integer          default(0)
#  second_moon_cycle  :integer          default(0)
#  third_moon_cycle   :integer          default(0)
#  article            :text
#  status             :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category_event_id  :bigint(8)
#  start              :datetime
#  end                :datetime
#  quarter_moon_cycle :integer          default(0)
#  description        :text
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
