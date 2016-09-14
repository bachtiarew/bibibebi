class Babysitter < ActiveRecord::Base
	belongs_to :user
	has_many :skills
	mount_uploader :photos, AvatarUploader
end
