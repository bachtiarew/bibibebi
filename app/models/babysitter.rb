class Babysitter < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :skills, join_table: "babysitter_skills"
	mount_uploader :photos, AvatarUploader
end
