class Babysitter < ActiveRecord::Base

	belongs_to :user 
	has_and_belongs_to_many :skills, join_table: "babysitter_skills", dependent: :destroy

	has_many :role_ratings, as: :cacheable
	has_many :pictures, as: :pictureable
	validates :nik , :age, :description, :price, presence: true

	ratyrate_rateable "quality"	, "original_score"
	
end
