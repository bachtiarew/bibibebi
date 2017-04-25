class OrtuSerializer < ApplicationSerializer
	has_many :pictures
	has_many :kids

	attributes(
		:id,
		:userParent,

		#virtual_attributes
		:firstname,
		:lastname,
		:address,
		:bornplace,
		:borndate,
		:phone_number,
		:gender,
		:email
	)

	def userParent
		object.user
	end

	def firstname
		object.user.firstname.titlecase
	end

	def lastname
		object.user.lastname.titlecase
	end

	def address
		object.user.address
	end

	def bornplace
		object.user.bornplace		
	end

	def borndate
		object.user.borndate
	end

	def gender
		object.user.gender
	end

	def email
		object.user.email
	end

	def phone_number
		object.user.phone_number
	end
end
