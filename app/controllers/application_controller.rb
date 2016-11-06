class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_action :configure_permitted_parameters, if: :devise_controller?  
  protect_from_forgery with: :exception

  protected

  # def configure_permitted_parameters
  # 	devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :bornplace, :borndate, :gender, :phone_number, :address, :email, :password, :password_confirmation) }  		
  # 	devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
  # 	devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
  # end

  helper_method :current_user

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
