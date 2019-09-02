# == Schema Information
#
# Table name: countries
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ApplicationRecord
	has_many :users
	validates :name, uniqueness: { case_sensitive: true, message: "Ya existe este País. Por favor verfique la información." }
end
