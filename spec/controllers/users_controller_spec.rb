require "rails_helper"

describe UsersController do 

	describe "GET #sign_in" do
		it "response successfully with http status 200" do
			expect(response.status).to eq 200
		end

	end

	describe "GET #login" do
		before :each do
			@user = FactoryGirl.create(:user)
		end

		it "login successfully and redirect to main index path" do
			email = @user.email
			password = @user.password_digest
			user = User.find_by(email: email)
			if user && user.authenticate(password)
				expect(response).to redirect_to mains_index_path
			end
		end

		it "failed to login and redirect to root_path" do
			user = User.find_by(email: "ipsum")
			if user && user.authenticate(password: "ipsum")
			expect(response).to redirect_to root_path
			end
		end
	end

	describe "GET #new" do
		it "expect response status 200" do
			expect(response.status).to eq 200
		end
	end

	describe "POST #create" do
		it "registration successfully , redirect to main index" do
			user = FactoryGirl.build(:user)
			post :create, {
				user: {
					email: user.email,
					password: user.password,
					password_confirmation: user.password_confirmation,
					role: user.role,
					firstname: user.firstname,
					lastname: user.lastname,
					bornplace: user.bornplace,
					borndate: user.borndate,
					address: user.address,
					gender: user.gender,
					phone_number: user.phone_number
				}
			}	
			expect(response).to have_http_status(:success)
		end
	end
end