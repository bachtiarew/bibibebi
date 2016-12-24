dispatcher.dispatch({
	actionType: "set-babysitter",
	babysitter: <%= @babysitter.to_json.html_safe %>,
	babysitterSkills: <%= @skills.to_json.html_safe %>,
	pictures: <%= @pictures[0].to_json.html_safe %>,
	user: <%= @user.to_json.html_safe %>
})
	