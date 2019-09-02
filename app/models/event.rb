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

class Event < ApplicationRecord
	belongs_to :category_event
	validates :title, uniqueness: { case_sensitive: true, message: "Evento ya ha sido registrado con anterioridad. Por favor verfique la información." }
end
