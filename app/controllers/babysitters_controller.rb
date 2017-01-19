class BabysittersController < ApplicationController
	before_action :current_user

	def index
		@babysitter = current_user.babysitter	
		@skills = @babysitter.skills
		@picture = Picture.find_by(pictureable_id: @babysitter.id, pictureable_type: "Babysitter")
	end

	def new
		@babysitter = Babysitter.new
		@skills = Skill.all
		if params[:mobile] == "true"
			@user = User.find(current_user.id)
		end
	end

	def create
		if current_user
			params[:babysitter][:user_id] = session[:user_id]
		end

		skill_ids = params[:babysitter].delete("skill_ids")
		selected_skills = []

		selected_skills = skill_ids.collect{ |skil_id| Skill.find(skil_id) }
		@babysitter = Babysitter.new(babysitter_params)
		
		if @babysitter.save
			@babysitter.skills = selected_skills
			save_picture!(@babysitter.id, "Babysitter", params[:babysitter][:photos])
			redirect_to babysitters_path
		else
			render_to 'new'
		end
	end

	#handle create babysitter for mobile
	def create_mobile
		@user = User.new(user_params)
		@babysitter = Babysitter.new(babysitter_params)
		
		if @user.save && @babysitter.save
			save_picture!(@babsyitter.id, "Babysitter", params[:babysitter][:pictures])
		else
			render :new, mobile: true 	
		end
		
	end

	def save_picture! (id, type, url)
		if url.present?
			params[:picture] = {}
			params[:picture][:picture_url] = url
			params[:picture][:pictureable_id] = id 
			params[:picture][:pictureable_type] = type
			@picture = Picture.new(picture_params)
			@picture.save
		end
	end

	def show
		@babysitter = Babysitter.find(params[:id])
		@skills = @babysitter.skills
		@user = @babysitter.user
		@pictures = []
		pictures = @babysitter.pictures
		pictures.each do |picture|
			@pictures << {
				id: picture.id,
				pictureId: picture.pictureable_id,
				pictureType: picture.pictureable_type,
				pictureUrl: picture.picture_url.url
			}
		end
		respond_to do |format|
			format.js do
				render :show
			end
		end
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
	
	skill_ids = params[:babysitter].delete("skills_ids")
	selected_skills = skill_ids.collect{ |skil_id| Skill.find(skil_id)}
	@babysitter = Babysitter.find(params[:id])	
	
	if 	@babysitter.update_attributes(babysitter_params)
		@babysitter.skills = selected_skills
		flash[:notice]="Your baby profile has been updated"
		redirect_to mains_index_path
	else
		flash[:alert]="your baby profile failed to update"
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

	def update_rate

	end

	private
	def babysitter_params
		params.require(:babysitter).permit(:nik, :age, :description, :user_id, :skills_id, :price)
	end

	def picture_params
		params.require(:picture).permit(:picture_url, :pictureable_id, :pictureable_type, )
	end

	def user_params
		params.require(:user).permit(:firstname, :lastname, :bornplace, :borndate, :gender, :address, :phone_number)
	end

end
