{ EventEmitter } = fbemitter

CHANGE_EVENT = "change"

window.MainpageMobileStore = _.assign(new EventEmitter(),{
	user: {}
	babysitter: {}
	parent: {}
	babysitters: []
	parents: []

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) ->
		@addListener(CHANGE_EVENT, callback)

	removeChangeListener: ->
		@removeAllListener(CHANGE_EVENT)

})

dispatcher.register (payload) ->
	if payload.actionType == "mainpage-mobile-set-babysitter"
		_.assign(MainpageMobileStore.user, payload.user)
		_.assign(MainpageMobileStore.babysitter, payload.babysitter)
		MainpageMobileStore.parents =payload.parents
		MainpageMobileStore.emitChange()

	if payload.actionType == "mainpage-mobile-set-parent"
		_.assign(MainpageMobileStore.user, payload.user)
		_.assign(MainpageMobileStore.parent, payload.parent)
		MainpageMobileStore.babysitters = payload.babysitters
		MainpageMobileStore.emitChange()
		