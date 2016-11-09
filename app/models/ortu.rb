class Ortu < ActiveRecord::Base

	has_many :kids, dependent: :destroy
	belongs_to :user

	mount_uploader :photos, AvatarUploader
	
end