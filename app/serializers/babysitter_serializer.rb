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
		:babysitter_skills,
		:firstname,
	  	:lastname,
	  	:gender,
	  	:borndate,
	  	:bornplace,
	  	:address,
	  	:phone_number,
	  	:email,
	  	:avgRate
		)

	#virtual attributes

	def babysitter_skills
		object.skills
	end

	def firstname
		object.user.firstname
	end

	def lastname
		object.user.lastname
	end

	def borndate
		object.user.borndate
	end

	def bornplace
		object.user.bornplace
	end

	def address
		object.user.address
	end

	def phone_number
		object.user.phone_number
	end 

	def gender
		object.user.gender
	end

	def email
		object.user.email
	end
		
	def avgRate
		avg_rate = RatingCache.find_by(cacheable_id: object.id, dimension: "quality", cacheable_type: "Babysitter")
		return avg_rate
	end	
end