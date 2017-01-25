class OrtuSerializer < ApplicationSerializer
	has_many :pictures
	has_many :kids

	attributes(
		:id
	)
end