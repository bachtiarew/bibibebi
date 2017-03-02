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
		:email,
		:age
	)

	def userParent
		object.user
	end

	def firstname
		object.user.firstname
	end

	def lastname
		object.user.lastname
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

	def age
		object.user.age
	end

end
