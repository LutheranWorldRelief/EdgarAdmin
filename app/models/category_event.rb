# == Schema Information
#
# Table name: category_events
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  color      :string
#

class CategoryEvent < ApplicationRecord
	has_many :events
end
