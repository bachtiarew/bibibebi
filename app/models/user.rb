class User < ActiveRecord::Base
	ratyrate_rater
	#for field validation : field should'n be empty
	validates :email, :password, :password_confirmation, presence: true , if: :sign_up?
	validates :firstname, :lastname, :gender, :bornplace, :borndate, :address, presence: true , if: :is_mobile?
	#validation for password : confirmation must matched
	validates :password, confirmation: true
	#validation for email : email that register must uniqueness
	validates :email , uniqueness: true

	has_one :babysitter, dependent: :destroy
	has_one :ortu, dependent: :destroy
	
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
		self.try(:ortu) ? true : false
	end

	#for mobile
	def is_mobile?
		@is_mobile = false
	end

	def is_mobile!
		@is_mobile = true
	end

	def sign_up?
		@sign_up = false
	end

	def sign_up!
		@sign_up = true
	end

	def user_complete?
		if self.firstname.present? && self.lastname.present? && self.bornplace.present? && self.borndate.present? && self.address.present? && self.gender.present? && self.phone_number.present?
			return true
		else
			return false
		end
	end

	def has_finish_user?
		if self.role == "babysitter"
			self.user_complete? && self.has_babysitter? ? "babysitter_finish" : "babysitter_not_finish"
		elsif 
			self.user_complete? && self.has_parent? ? "parent_finish" : "parent_not_finish"
		end
	end
end
