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

class Tutorial < ApplicationRecord
	validates :name, :video_link, presence: true
end
