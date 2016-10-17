class HomepagesController < ApplicationController

	#control homepage
	def index
		if session[:user_id] != nil
			redirect_to mains_index_path
		end
	end

end
