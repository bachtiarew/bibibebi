class BabysitterSerializer < ApplicationSerializer

	has_many :pictures
	# has_and_belongs_to_many :skills

	attributes(
		:nik,
		:age,
		:description,
		:user_id
		)

end