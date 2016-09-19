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

	def show
		@babysitter = Babysitter.find(params[:id])
		@skills = @babysitter.skills
	end

	def edit
	@babysitter = Babysitter.find(params[:id])
	@skill = Skill.all
	@babysitter_skills = @babysitter.skills
	end
	
	def update
		if current_user
			params[:babysitter][:user_id] = session[:user_id]
		end
	@babysitter_skills = Babysitter_skills.find_by_babysitter_id(params[:babysitter][:id])
	@babysitter_skills.destroy
	@babysitter = Babysitter.find(params[:id])
	skill_ids = params[:babysitter].delete("skill_ids")
	selected_skills = skill_ids.collect{ |skil_id| Skill.find(skil_id)}	
	@babysitter = @babysitter.update(babysitter_params)
	if @babysitter.update
		@babysitter.skills = selected_skills
		flash[:notice]="Your baby profile has been updated"
		redirect_to mains_index_path
	else
		flash[:aler]="your baby profile failed to update"
		redirect_to edit_babysitter_path
	end
	end

	def destroy
	@babysitter = Babysitter.find(params[:id])
	@babysitter_skills = @babysitter.destroy

		if @babysitter_skills
			flash[:notice] = "babysitter profile has been deleted"
			redirect_to mains_index_path
		else
			flash[:alert] = "babysitter profiled failed to deleted"
			redirect_to babysitter_path(@babysitter)
		end
	end

	private
	def babysitter_params
		params.require(:babysitter).permit(:nik, :age, :description, :photos, :user_id)
	end

end
