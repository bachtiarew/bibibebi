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
		_.assign(MainpageMobileStore, payload.user)
		_.assign(MainpageMobileStore, payload.babysitter)
		MainpageMobileStore.parents =payload.parents
		MainpageMobileStore.emitChange()

	if payload.actionType == "mainpage-mobile-set-parent"
		_.assign(MainpageMobileStore, payload.user)
		_.assign(MainpageMobileStore, payload.parent)
		MainpageMobileStore.babysitters = payload.babysitters
		MainpageMobileStore.emitChange()
		