class Skill < ActiveRecord::Base
	has_many :babysitter_has_skills
	has_many :babysitters, through: :babysitter_has_skills
end