{ EventEmitter } = fbemitter

CHANGE_EVENT = "change"

window.BabysitterFormMobileStore = _.assign(new EventEmitter(),{
	user: {} 
	babysitter: {}
	skills: []

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) ->
		@addListener(CHANGE_EVENT, callback)

	removeChangeListener: ->
		@removeAllListener(CHANGE_EVENT)

})

dispatcher.register (payload) ->
	if payload.actionType == "babysitter-mobile-set-user"
		_.assign(BabysitterFormMobileStore, payload.attributes)

		BabysitterFormMobileStore.emitChange()
	else if payload.actionType == "babysitter-mobile-set-babysitter"
		_.assign(BabysitterFormMobileStore, payload.attributes)

		BabysitterFormMobileStore.emitChange()
	else if payload.actionType == "babysitter-mobile-set-skills"
		BabysitterFormMobileStore.skills = payload.skills

		BabysitterFormMobileStore.emitChange()