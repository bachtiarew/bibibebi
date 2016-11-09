class ParentsController < ApplicationController
	
	def index
		@babysitters = Babysitter.all
		@thumbs = @babysitters
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
				Kid.create(
					name: child[:name],
					gender: child[:gender],
					age: child[:age],
					description: child[:description],
					ortu_id: parent_id
					)
			end

			flash[:notice] = "Parents child data has been saved!"
			redirect_to parents_path
		else
			flash[:alert] = "Parent child data failed to save, please try again!"
			redirect_to new_parent_path
		end

	end

	def show
		@parent = Ortu.find(params[:id])
		@childs = @parent.kids
	end

	private
	def parent_params
		params.require(:parent).permit(:photos, :user_id)
	end


end