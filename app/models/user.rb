class User < ActiveRecord::Base
	ratyrate_rater
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

	def has_finish_account?
		if self.role == "parent"
			self.has_parent? ? "parent_finish" : "parent_not_finish"
		else
			self.has_babysitter? ? "babysitter_finish" : "babysitter_not_finish"
		end
	end

	def has_babysitter?
		self.try(:babysitter) ? true : false
	end

	def has_parent?
		self.try(:parent) ? true : false
	end


end
