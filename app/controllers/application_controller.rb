class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def selection_child(kids)
	childs = []
	kids.each do |kid|
		if kid[:_destroy] == nil
			childs << kid
		end
	end
	return childs
	
  end
	
end
