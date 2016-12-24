{EventEmitter} = fbemitter

CHANGE_EVENT = 'change'


window.BabysitterStore = _.assign(new EventEmitter(),{ 
	babysitter: {}
	babysitterSkills: null
	pictures: {}
	user: {}

	emitChange: ->
		console.log("kena emit dong")
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) ->
		@addListener(CHANGE_EVENT, callback)

	removeChangelistener: ->
		@removeAllListener(CHANGE_EVENT)

})

dispatcher.register (payload) ->
	console.log("kena dispatcher")
	console.log("ppayload babysitter", payload.babysitter)
	console.log("ppayload skills", payload.babysitterSkills)
	if payload.actionType == "set-babysitter"
		_.assign(BabysitterStore.babysitter, payload.babysitter)
		_.assign(BabysitterStore.user, payload.user)
		_.assign(BabysitterStore.pictures, payload.pictures)
		BabysitterStore.babysitterSkills = payload.babysitterSkills

		BabysitterStore.emitChange()