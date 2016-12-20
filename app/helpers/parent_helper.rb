module ParentHelper

	def has_parent?
		@parents = Ortu.find_by_user_id(session[:user_id])
		unless @parents
			link_to 'Create Parent Profile', new_parent_path
		else
			link_to 'Parent Profile', parent_path(@parents)
		end
	end 

	def get_parents
		parents = Ortu.all
		parents.as_json( except: [:password_digest], include: [:user, :pictures])
	end

	def get_parent
		current_user.ortu.as_json(include: [:kids, :user])
	end

end