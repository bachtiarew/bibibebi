class Babysitter < ActiveRecord::Base
	belongs_to :user
	mount_uploader :photos, AvatarUploader
end
