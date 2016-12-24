class UserSerializer < ApplicationSerializer
  
  has_one: babysitter
  has_one: parent
  
  attributes(
  	:firstname,
  	:lastname,
  	:borndate,
  	:bornplace,
  	:address,
  	:phone_number,
  	:email
  	)

end
