{EventEmitter} = fbemitter

CHANGE_EVENT = 'change'


window.BabysitterStore = _.assign(new EventEmitter(),{ 
	babysitter: {}
	babysitterSkills: null

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