class UsersController < ApplicationController
	#POST/users
	#POST/users.json
	def sign_in
		@user = User.new
	end

	def logout
		session[:user_id] = nil
		redirect_to root_path
	end

	def login
		email = params[:email]
		password = params[:password]
		@user = User.find_by(email: email)
		if @user && @user.authenticate(password)
			flash[:notice] = "Your sign in was successfully"
			session[:user_id] = @user.id
			redirect_to mains_index_path
		else
			flash[:alert] = "Your email or password not correctly"
			redirect_to root_path

		end

	end

	def new
		@user = User.new
	end

	def create
		byebug
		@user = User.new(user_params)
		if @user.save
			UserMailer.welcome_email(@user).deliver_now
			session[:user_id] = @user.id
			flash[:notice] = "Your Sign Up was successfully"
			redirect_to mains_index_path
		else
			flash[:alert] = "Your Sign Up has failed, please try again"
			render 'new'
		end

	end

	#any params must be permitted before save to database
	private
	def user_params
		# params[:users][:role] = "user"
		params.require(:users).permit(:firstname, :lastname, :gender, :bornplace, :borndate, :email, :password, :password_confirmation, :role, :address, :phone_number)
	end


end
