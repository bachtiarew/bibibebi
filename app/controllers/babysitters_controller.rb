class BabysittersController < ApplicationController

	def new
		@babysitter = Babysitter.new
		@skill = Skill.all
	end

	def create
			if current_user
				params[:babysitter][:user_id] = session[:user_id]
			end
			skill_ids = params[:babysitter].delete("skill_ids")
			selected_skills = []

			selected_skills = skill_ids.collect{ |skil_id| Skill.find(skil_id)}

			@babysitter = Babysitter.new(babysitter_params)
			if @babysitter.save
				@babysitter.skills = selected_skills
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
