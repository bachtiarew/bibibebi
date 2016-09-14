class MainsController < ApplicationController

	def index
		if session[:user_id] == nil
			redirect_to root_path
		end
		@user = User.find(session[:user_id])
	end


end
