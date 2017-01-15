{EventEmitter} = fbemitter

CHANGE_EVENT = 'change'


window.HomepagesMobileStore = _.assign(new EventEmitter(),{ 
	showMenu: false	
	showForm: false
	showLoginForm: false
	infos: []
	numberInfo: 0
	user: {email: null, passwor: null, role: null}
	activeButton: {babysitter: false, parent: false}

	addInfo: (Obj) ->
		@info.push(arrObj)
		@emitChange()

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) ->
		@addListener(CHANGE_EVENT, callback)

	removeChangelistener: ->
		@removeAllListener(CHANGE_EVENT)

})

dispatcher.register (payload) ->
	if payload.actionType == "homepage-mobile-change-header"
		_.assign(HomepagesMobileStore, payload.attributes)

		HomepagesMobileStore.emitChange()
	else if payload.actionType == "homepage-set-infos"
		HomepagesMobileStore.infos = payload.infos
	
		HomepagesMobileStore.emitChange()
	else if payload.actionType == "homepage-mobile-change-number-info"
		HomepagesMobileStore.numberInfo = payload.numberInfo

		HomepagesMobileStore.emitChange()
	else if payload.actionType == "homepage-mobile-change-user"
		_.assign(HomepagesMobileStore.user, payload.attributes)

		HomepagesMobileStore.emitChange()
	else if payload.actionType == "homepage-mobile-change-active-button"
		_.assign(HomepagesMobileStore.activeButton, payload.attributes)

		HomepagesMobileStore.emitChange()
