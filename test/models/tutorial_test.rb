# == Schema Information
#
# Table name: tutorials
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  video_link :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TutorialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
