class ParentsController < ApplicationController

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
		
		@parent = Parent.new(parent_params)

		if @parent.save
			parent_id = @parent.id
			@child_items.each do |child|
				Kid.create(
					name: child[:name],
					gender: child[:gender],
					age: child[:age],
					description: child[:description],
					parent_id: parent_id
					)
			end

			flash[:notice] = "Parents child data has been saved!"
			redirect_to mains_index_path
		else
			flash[:alert] = "Parent child data failed to save, please try again!"
			redirect_to new_parent_path
		end

	end

	def show
		
	end

	private
	def parent_params
		params.require(:parent).permit(:photos, :user_id)
	end


end