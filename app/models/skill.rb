class Skill < ActiveRecord::Base
	has_and_belongs_to_many :babysitters, join_table: "babysitter_skills"

	validates :name, :description, :score, presence: true

end
