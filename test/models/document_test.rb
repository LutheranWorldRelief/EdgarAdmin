# == Schema Information
#
# Table name: documents
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  file       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
