class MainsController < ApplicationController
	
	def index
		if !current_user
			redirect_to root_path
		end
		@user = current_user
		thumb_role = current_user.role == "parent" ? "babysitter" : "parent"
		
		unless params[:mobile] == "true"
			thumbs = User.where(role: thumb_role)
			
			@thumbs = thumbs.as_json( except: [:password_digest], include: :babysitter)
		else
			if thumb_role == "babysitter"
				@babysitter = current_user.parent
				@parents = Ortu.all
			else
				@parent = current_user.parent
				@babysitter = Babysitte.all
			end

		end
	end

end
