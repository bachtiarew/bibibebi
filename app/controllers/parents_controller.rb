class ParentsController < ApplicationController
	before_action :authenticate_checking
	before_action :set_picture, only:[:index]
	before_action :set_pictures, only:[:index]

	def index
		unless params[:mobile] == "true"
			@parent = current_user.ortu
			@picture = Picture.find_by(pictureable_id: @parent.id, pictureable_type: "Ortu")
			@user = current_user
			@babysitters = Babysitter.all
		else
			@user = current_user
			@parent = current_user.ortu
			@babysitters = Babysitter.all
		end
	end

	def new
		
	end

	def get_user
		redirect_to root_path unless current_user
		render json: @current_user
	end

	def create
		if current_user
			params[:parent][:user_id] = session[:user_id]
		end
		@child_items = params[:parent].delete('child_items')
		@childs = selection_child(@child_items)
		@parent = Ortu.new(parent_params)
		if @parent.save
			parent_id = @parent.id
			@childs.each do |child|
				kid = Kid.create(
					name: child[:name],
					gender: child[:gender],
					age: child[:age],
					description: child[:description],
					ortu_id: parent_id
					)	
				save_picture!(kid.id, "Kid", child[:picture_url])
			end
			save_picture!(@parent.id, "Ortu", params[:parent][:picture_url])			
			flash[:notice] = "Parents child data has been saved!"
			redirect_to parents_path
		else
			flash[:alert] = "Parent child data failed to save, please try again!"
			redirect_to new_parent_path
		end

	end

	def save_picture!(id, type, url)
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
		@parent = Ortu.find(params[:id])
		childs = @parent.kids
		pictures = @parent.pictures
		@parent_pictures = []
		pictures.each do |picture|
			@parent_pictures << {
				id: picture.id,
				pictureId: picture.pictureable_id,
				pictureUrl: picture.pictureable_type
			}
		end
		@childs = []
		childs.each do |child|
			@childs << {
				name: child.name,
				gender: child.gender,
				description: child.description, 
				picture: {
					id: child.pictures[0].id,
					pictureId: child.pictures[0].pictureable_id,
					pictureUrl: child.pictures[0].pictureable_type
				}
			}
		end
		
		respond_to do |format|
			format.html { render :show }
			format.js do
				render :show
			end
		end
	end

	def set_picture
		@parent = current_user.ortu
		@picture = Picture.find_by(pictureable_id: @parent.id) 
	end

	def set_pictures
		@pictures = Picture.where(pictureable_type: "Babysitter")
	end

	private
	def parent_params
		params.require(:parent).permit(:user_id)
	end

	private
	def picture_params
		params.require(:picture).permit(:picture_url, :pictureable_id, :pictureable_type)
	end
end