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
			flash[:notice] = "Anda berhasil masuk"
			session[:user_id] = @user.id
			status = @user.has_finish_account?
			
			if status == "parent_finish"
				redirect_to parents_path
			elsif status == "babysitter_finish"
				redirect_to babysitters_path
			elsif status == "parent_not_finish"
				redirect_to new_parent_path
			elsif status == "babysitter_not_finish"
				redirect_to new_babysitter_path
			end	
		else
			flash[:alert] = "Email atau password anda salah, silahkan coba kembali"
			redirect_to root_path
		end

	end

	#handle login for mobile version
	def login_mobile
		email = params[:user][:email]
		password = params[:user][:password]
		@user = User.find_by(email: email)
		if @user && @user.authenticate(password)
			flash[:notice] = "Anda berhasil masuk"
			session[:user_id] = @user.id
			status = @user.has_finish_user?
			byebug
			if status == "parent_finish"
				redirect_to parents_path
			elsif status == "babysitter_finish"
				redirect_to babysitters_path
			elsif status == "parent_not_finish"
				redirect_to new_parent_path(mobile: true)
			elsif status == "babysitter_not_finish"
				redirect_to new_babysitter_path(mobile: true)
			end	
		else
			flash[:alert] = "Email atau password anda salah, silahkan coba kembali"
			redirect_to root_path
		end				
	end

	def new
		@user = User.new
	end

	def create
		role = params[:role]
		params[:user][:password] = params[:password]
		params[:user][:password_confirmation] = params[:password_confirmation]
		@user = User.new(user_params)
		if @user.save
			UserMailer.welcome_email(@user).deliver_now
			session[:user_id] = @user.id
			flash[:notice] = "Your Sign Up was successfully"
			if role == "parent"
				redirect_to new_parent_path
			else
				redirect_to new_babysitter_path
			end
		else
			flash[:alert] = "Your Sign Up has been failed , please fill correctly"
			redirect_to root_path
		end

	end

	#controller for handle application on mobile version
	def create_mobile
		role = params[:user][:role]
		@user = User.new(user_mobile_params)
		@user.is_mobile!
		if @user.save
			UserMailer.welcome_email(@user).deliver_now
			session[:user_id] = @user.id
			if role == "babysitter"
				redirect_to new_babysitter_path(mobile: true)
			elsif role == "parent"
				redirect_to new_parent_path(mobile: true)
			end
		else
			@hasIn = true
			render "Homepages/index"
		end
	end

	def coba
		nama = params[:user][:name]
		jsonku = {nama: nama, age: 24}
		@user = User.last
		
		respond_to do |format|	
			format.json { render json: @user }
		end		
	end

	#any params must be permitted before save to database
	private
	def user_params
		# params[:users][:role] = "user"
		params.require(:user).permit(:firstname, :lastname, :gender, :bornplace, :borndate, :email, :password, :password_confirmation, :role, :address, :phone_number)
	end

	#user params untuk versi mobile
	def user_mobile_params
		params.require(:user).permit(:email, :password, :password_confirmation, :role)	
	end

end
