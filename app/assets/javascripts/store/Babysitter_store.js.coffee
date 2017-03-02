{EventEmitter} = fbemitter

CHANGE_EVENT = 'change'


window.BabysitterStore = _.assign(new EventEmitter(),{ 
	babysitter: {}
	babysitterSkills: null
	skillIcon: [
		{id: 5, iconClassName: "fa fa-pencil fa-2x"}
		{id: 6, iconClassName: "fa fa-leaf fa-2x"}
		{id: 7, iconClassName: "fa fa-star fa-2x"}
		{id: 8, iconClassName: "fa fa-user fa-2x"}
	]
	editMode: false
	formAuthenticitytoken: null

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) ->
		@addListener(CHANGE_EVENT, callback)

	removeChangelistener: ->
		@removeAllListener(CHANGE_EVENT)

})

dispatcher.register (payload) ->
	if payload.actionType == "set-babysitter"
		_.assign(BabysitterStore.babysitter, payload.babysitter)
		_.assign(BabysitterStore.babysitter, payload.pictures)
		_.assign(BabysitterStore.babysitter, payload.user)
		BabysitterStore.babysitterSkills = payload.babysitterSkills

		BabysitterStore.emitChange()
	else if payload.actionType == "set-babysitter-mobile"
		_.assign(BabysitterStore, payload.babysitter)
		BabysitterStore.emitChange()

	else if payload.actionType == "babysitter-change-edit-mode"
		BabysitterStore.editMode = payload.editMode
		BabysitterStore.emitChange()

	else if payload.actionType == "babysitter-form-authenticity-token"
		BabysitterStore.formAuthenticitytoken = payload.formAuthenticitytoken
		BabysitterStore.emitChange()