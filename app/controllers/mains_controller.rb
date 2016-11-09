class MainsController < ApplicationController
	
	def index
		if !current_user
			redirect_to root_path
		end
		@user = current_user
		thumb_role = current_user.role == "parent" ? "babysitter" : "parent"
		
		thumbs = User.where(role: thumb_role)
		
		@thumbs = thumbs.as_json( except: [:password_digest], include: :babysitter)
	end

end
