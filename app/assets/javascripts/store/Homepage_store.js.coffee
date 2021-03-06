{EventEmitter} = fbemitter

CHANGE_EVENT = 'change'


window.HomepageStore = _.assign(new EventEmitter(),{ 
	user: {}
	error: null
	status: null
	modal: false
	requesting: {type: null, status: false, submitting: false}

	createBlankForm: ->
		@user = {
			firstname: null
			lastname: null
			gender: "male"
			role: null
			bornplace: null
			borndate: null
			address: null
			phone_number: null
			email: null
			password: null
			password_confirmation: null
		}

	setModal: (status) ->
		@status = status
		@modal = !@modal
		@emitChange()

	closeModal: (status) ->
		@status = status
		@modal = !@modal
		@emitChange()

	submitSignUp: (newUser) ->
		@emitChange()

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) ->
		@addListener(CHANGE_EVENT, callback)

	removeChangelistener: ->
		@removeAllListener(CHANGE_EVENT)

})

dispatcher.register (payload) ->
	if payload.actionType == "set-modal"
		HomepageStore.setModal(payload.status)

	if payload.actionType == "submit-sign-up"
		HomepageStore.submitSignUp(payload.newUser)

	if payload.actionType == "close-modal"
		HomepageStore.closeModal(payload.status)

	if payload.actionType == "set-user-data"
		HomepageStore.user = payload.user
		HomepageStore.emitChange()

	if payload.actionType == "user-view-change"
		_.assign(HomepageStore.user, payload.attributes)
		HomepageStore.emitChange()

	if payload.actionType == "set-requesting"
		HomepageStore.requesting = payload.attributes
		HomepageStore.emitChange()