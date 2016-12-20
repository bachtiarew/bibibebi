class HomepagesController < ApplicationController

	#control homepage
	def index
		if session[:user_id] != nil
			redirect_to mains_index_path
		end
	end

	def frame

	end

	def copas
		respond_to do |format|
			params[:frame] = {}
			params[:frame][:attachment] = params[:attachment]
			@frame = Frame.new(picture_params)
			if @frame.save
				@dest_url = @frame.attachment.url
			end
			format.js do
				render :copas
			end 
		end
	end

	private
	def picture_params
		params.require("frame").permit("attachment")
	end

end
