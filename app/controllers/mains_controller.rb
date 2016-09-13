class MainsController < ApplicationController

	def index
		
		if session[:user_id] == nil
			redirect_to root_path
		end

	end

end
