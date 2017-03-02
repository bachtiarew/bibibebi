dispatcher.dispatch({
	actionType: "babysitter-mobile-set-user",
	attributes: <%= json_for(@user).html_safe %>	
})

dispatcher.dispatch({
	actionType: "babysitter-mobile-set-babysitter",
	attributes: <%= json_for(@babysitter).html_safe %>
})

dispatcher.dispatch({
    actionType: "babysitter-mobile-set-skills",
    skills: <%= json_for(@skills).html_safe %>
 })

dispatcher.dispatch({
	actionType: "babysitter-change-edit-mode",
	editMode: true
})
