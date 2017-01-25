class BabysittersController < ApplicationController
	before_action :current_user

	def index
		@babysitter = current_user.babysitter	
		@skills = @babysitter.skills
		@picture = Picture.find_by(pictureable_id: @babysitter.id, pictureable_type: "Babysitter")
	end

	def new
		if params[:mobile] == "true"
			@user = User.find(current_user.id)
		end
		@babysitter = current_user.babysitter.present?  ? current_user.babysitter : Babysitter.new
		@skills = Skill.all
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
		unless check_params_complete_data
			flash[:warning] = "pastikan semua data telah terisi !"
			redirect_to new_babysitter_path(mobile: "true")
		end

		params[:babysitter][:user_id] = current_user.id
		price = params[:babysitter][:price]
		params[:babysitter][:price] = price.to_i / 1000
		@user = User.find(current_user)

		skill_ids = params[:babysitter].delete("skill_ids")
		selected_skills  = []
		selected_skills = skill_ids.collect{ |skill_id| Skill.find(skill_id) } unless skill_ids.blank?
		
		unless @user.update_attributes(user_params)
			render "new", mobile: "true"
		end

		@babysitter = Babysitter.new(babysitter_params)
		unless @babysitter.save
			render "new", mobile: "true"
		end

		@babysitter.skills = selected_skills unless selected_skills.blank?
		save_picture!(@babysitter.id, "Babysitter", params[:babysitter][:picture_url])
		redirect_to mains_index_path
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

	def save_document!(id, type, url)
		if url.present?
			params[:document] = {}
			params[:document][:document_url] = url
			params[:document][:documentable_id] = id
			params[:document][:documentable_type] = type
			@document = Document.new(document_params)
			@document.save
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

	def check_params_complete_data
		return false if params[:user][:firstname].nil?
		return false if params[:user][:lastname].nil?
		return false if params[:user][:bornplace].nil?
		return false if params[:user][:borndate].nil?
		return false if params[:user][:gender].nil?
		return false if params[:user][:address].nil?
		return false if params[:user][:phone_number].nil?
		return false if params[:babysitter][:nik].nil? 
		return false if params[:babysitter][:picture].nil?
		return false if params[:babysitter][:skill_ids].nil?
		return false if params[:babysitter][:price].nil?
		return false if params[:babysitter][:description].nil?
		return false if params[:babysitter][:age].nil?

		return true
	end

	private
	def babysitter_params
		params.require(:babysitter).permit(:nik, :age, :description, :user_id, :skills_id, :price)
	end

	def picture_params
		params.require(:picture).permit(:picture_url, :pictureable_id, :pictureable_type)
	end

	def picture_mobile_params
		params.require(:picture).permit(:picture_url, :remote_picture_url_url, :pictureable_id, :pictureable_type)
	end

	def document_params
		params.require(:document).permit(:document_url, :documentable_id, :documentable_type)
	end

	def user_params
		params.require(:user).permit(:firstname, :lastname, :bornplace, :borndate, :gender, :address, :phone_number)
	end

end
