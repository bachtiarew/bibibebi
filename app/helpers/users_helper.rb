module UsersHelper
	
	def get_current_user
		current_user.as_json(except: :password_digest)
	end	
end
