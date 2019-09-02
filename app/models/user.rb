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
#  area_code              :string
#

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
         
  belongs_to :country, optional: true

  validates :email, uniqueness: true
  validates :username, :birth_date, :genre, :country_id, :phone, presence: true

  after_create :user_age

  def role_is
  	if self.has_role? :admin
  		return "Administrador"
  	end
  	if self.has_role? :tecnhical
  		return "Técnico"
  	end
  	if self.has_role? :producer
  		return "Productor"
  	end
  end

  def assign_user(id)
    producer = User.find(id)
    if producer.has_role? :producer
      users= User.with_role(:tecnhical)
      tecnhical = users.where(chat_counter: users.where(country_id: producer.country_id).minimum(:chat_counter)).first
      UserChat.create(user_producer: producer.id, user_technical: tecnhical.id)
      tecnhical.chat_counter += 1
      tecnhical.save
    end
  end

  def save_url_chat(id, url_chat)
    user_chat = UserChat.find(id)
    user_chat.url_chat = url_chat
    if user_chat.save
      return true
    else
      return false
    end
  end

  def user_age
    if self.birth_date.present?
      now = Date.today
      return now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
    else
      return ''
    end
  end

end
