class BabysitterSerializer < ApplicationSerializer

	has_many :pictures
	# has_and_belongs_to_many :skills

	attributes(
		:id,
		:nik,
		:age,
		:description,
		:user_id,
		:price,

	#virtual attributes
		:babysitter_skills
		)

	#virtual attributes

	def babysitter_skills
		object.skills
	end
	
end