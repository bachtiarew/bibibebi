class MainsController < ApplicationController
	
	def index
		if !current_user
			redirect_to root_path
		end
		@user = current_user
			
		unless params[:mobile] == "true"
			thumb_role = current_user.role == "parent" ? "babysitter" : "parent"
			thumbs = User.where(role: thumb_role)
			
			@thumbs = thumbs.as_json( except: [:password_digest], include: :babysitter)
		else
			if @user.role == "babysitter"
				@babysitter = current_user.babysitter
				@parents = Ortu.all
			else
				@parent = current_user.ortu
				@babysitter = Babysitte.all
			end
		end
	end

end
