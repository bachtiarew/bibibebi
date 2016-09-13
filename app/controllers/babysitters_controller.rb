class BabysittersController < ApplicationController

	def new

	end

	def create
			if current_user
				params[:babysitter][:user_id] = session[:user_id]
			end
			@babysitter = Babysitter.new(babysitter_params)
			byebug
			if @babysitter.save
				redirect_to mains_index_path
			else
				render_to 'new'
			end


	end

	private
	def babysitter_params
		params.require(:babysitter).permit(:nik, :age, :description, :photos, :user_id)
	end

end
