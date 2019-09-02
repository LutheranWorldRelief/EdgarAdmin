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

class Document < ApplicationRecord
	validates :name, uniqueness: { case_sensitive: true, message: "Ya existe un documento con el mismo nombre. Por favor verfique la información o escriba un nombre diferente." }
	validates :name, presence: true
	mount_uploader :file , AvatarUploader
end
