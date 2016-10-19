module ApplicationHelper

	def alert_error(alert)
		return {alertLabel: alert, alertType: "error"}
	end

	def alert_notice(alert)
		return {alertLabel: alert, alertType: "notify"}
	end

end
