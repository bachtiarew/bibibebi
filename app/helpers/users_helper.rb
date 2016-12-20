module UsersHelper
	
	def get_user
		current_user.as_json(except: :password_digest)
	end	
end
