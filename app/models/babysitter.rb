class Babysitter < ActiveRecord::Base
	belongs_to :user 
	has_and_belongs_to_many :skills, join_table: "babysitter_skills", dependent: :destroy
	mount_uploader :photos, AvatarUploader

	validates :nik , :age, :description, presence: true
	
end
