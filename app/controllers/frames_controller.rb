class FramesController < ApplicationController

	def index

	end

	def new

	end

	def create
	end	

	def upload_picture
		respond_to do |format|
			params[:frame] = {}
			params[:frame][:attachment] = params[:attachment]
			@frame = Frame.new(picture_params)
			if @frame.save
				@dest_url = @frame.attachment.url
			end
			format.json{@dest_url}
		end
	end

	private
	def picture_params
		params.require("frame").permit("attachment")
	end

end