class UserMailer < ApplicationMailer
	default from: "admin@bibibebi.com"

	def welcome_email(user)
		@user = user
		@url = 'http//www.bibibebi.com/homepages/index'
		mail(to: @user.email, subject: 'Welcome to bibibebi site')
	end
end
