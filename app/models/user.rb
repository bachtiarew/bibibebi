class User < ActiveRecord::Base
	#for field validation : field should'n be empty
	validates :firstname, :lastname, :bornplace, :borndate, :address, :email, :password, :password_confirmation, presence: true
	#validation for password : confirmation must matched
	validates :password, confirmation: true
	#validation for email : email that register must uniqueness
	validates :email , uniqueness: true

	has_one :babysitter
	has_secure_password


end
