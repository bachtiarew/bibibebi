class Babysitter < ActiveRecord::Base
	belongs_to :user
	has_many :babysitter_has_skills
	has_many :skills, through: :babysitter_has_skills
	mount_uploader :photos, AvatarUploader
end
