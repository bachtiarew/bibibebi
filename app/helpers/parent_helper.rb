module ParentHelper

	def has_parent?
		@parents = Parent.find_by_user_id(session[:user_id])
		unless @parents
			link_to 'Create Parent Profile', new_parent_path
		else
			link_to 'Parent Profile', parent_path(@parents)
		end
	end 

end