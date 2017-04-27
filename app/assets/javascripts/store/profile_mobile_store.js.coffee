{ EventEmitter } = fbemitter

CHANGE_EVENT = "change"

window.ProfileMobileStore = _.assign(new EventEmitter(), {
	currentUser: {}
	parent: {}
	babysitter: {}
	skillChoosed: {}
	kidChoosed: {}
	iconSkills : [
		{id: 5, icon: "fa fa-hourglass-end"},
		{id: 6, icon: "fa fa-diamond"},
		{id: 7, icon: "fa fa-trash"},
		{id: 8, icon: "fa fa-book"}
	]
	navbarUrl:
		babysitter: ["/babysitters", "/babysitters/", "/babysitters", "/babysitters", "/babysitters"]
		parent: ["/parents", "/parents/", "/parents", "/parents"]

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) ->
		@addListener(CHANGE_EVENT, callback)

	removeChangeListener: (callback) ->
		@removeAllListener(CHANGE_EVENT)

})

dispatcher.register (payload) ->
	if payload.actionType == "profile-mobile-store-set-babysitter"
		_.assign(ProfileMobileStore.currentUser, payload.currentUser.user)
		_.assign(ProfileMobileStore, payload.babysitter)
		ProfileMobileStore.emitChange()

	if payload.actionType == "profile-mobile-set-store-set-parent"
		_.assign(ProfileMobileStore.currentUser, payload.currentUser.user)
		_.assign(ProfileMobileStore.parent, payload.parent)
		ProfileMobileStore.emitChange()

	if payload.actionType == "profile-mobile-store-set-babysitter-skill-choosed"
		console.log("harusnya kenna lah")
		_.assign(ProfileMobileStore.skillChoosed, payload.skillChoosed)
		ProfileMobileStore.emitChange()
	