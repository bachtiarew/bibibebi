module ApplicationHelper

	def alert_error(alert)
		return {alertLabel: alert, alertType: "error"}
	end

	def alert_notice(alert)
		return {alertLabel: alert, alertType: "notify"}
	end

	def user_email
		current_user.email
	end

	def get_thumbs
		if current_user.is_babysitter?
			get_parents
		else
			get_babysitters
		end
	end

	def main_page_url
		if current_user.is_babysitter?
			babysitters_path
		else
			parents_path
		end
	end

end
