class User < ActiveRecord::Base
	#for field validation : field should'n be empty
	validates :firstname, :lastname, :gender, :bornplace, :borndate, :address, :email, :password, :password_confirmation, presence: true
	#validation for password : confirmation must matched
	validates :password, confirmation: true
	#validation for email : email that register must uniqueness
	validates :email , uniqueness: true

	has_one :babysitter
	has_one :parentchild
	has_secure_password

	def is_babysitter?
		self.role == "babysitter" ? true : false
	end

	def is_parent?
		self.role == "parent" ? true : false
	end

end
