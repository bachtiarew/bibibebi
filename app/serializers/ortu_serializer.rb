class OrtuSerializer < ApplicationSerializer
	has_many :pictures
	has_many :kids

	attributes(
		:id,
		:userParent
	)

	def userParent
		object.user
	end

end
