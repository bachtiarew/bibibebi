class KidSerializer < ApplicationSerializer
	has_many :pictures
	
	attributes(
		:id,
		:name,
		:gender,
		:age
	)

end
