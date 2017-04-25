{ EventEmitter } = fbemitter

CHANGE_EVENT = "change"

window.MainpageMobileStore = _.assign(new EventEmitter(),{
	user: {}
	babysitter: {}
	parent: {}
	babysitters: []
	parents: []
	parentChoosed: {}
	babysitterChoosed: {}
	navbarUrl:
		babysitter: ["/babysitters", "/babysitters/", "/babysitters", "/babysitters", "/babysitters"]
		parent: ["/parents", "/parents/", "/parents", "/parents", "/parents"]

	setBabysitterChoosed: (babysitterChoosed) ->
		_.each(@babysitters, (e) ->
			e.choosed = if e.id == babysitterChoosed.id then true else null
		)

	setParentChoosed: (parentChoosed) ->
		_.each(@parents, (e) ->
			e.choosed = if e.id == parentChoosed.id then true else null 
		)

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
		MainpageMobileStore.parents = payload.parents
		MainpageMobileStore.emitChange()

	if payload.actionType == "mainpage-mobile-set-parent"
		_.assign(MainpageMobileStore, payload.user)
		_.assign(MainpageMobileStore, payload.parent)
		MainpageMobileStore.babysitters = payload.babysitters
		MainpageMobileStore.emitChange()
	
	if payload.actionType == "mainpage-mobile-set-parent-choosed"
		_.assign(MainpageMobileStore.parentChoosed, payload.attributes)
		MainpageMobileStore.setParentChoosed(payload.attributes)
		MainpageMobileStore.emitChange()

	if payload.actionType == "mainpage-mobile-set-babysitter-choosed"
		_.assign(MainpageMobileStore.babysitterChoosed, payload.attributes)
		MainpageMobileStore.setBabysitterChoosed(payload.attributes)
		MainpageMobileStore.emitChange()