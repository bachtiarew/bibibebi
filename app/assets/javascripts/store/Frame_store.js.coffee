{EventEmitter} = fbemitter

CHANGE_EVENT = 'change'


window.FrameStore = _.assign(new EventEmitter(),{ 
	destUrl: ""
	
	setDestUrl: (url) ->
		@destUrl = url
		@emitChange()

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) ->
		@addListener(CHANGE_EVENT, callback)

	removeChangeListener: ->
		@removeAllListener(CHANGE_EVENT)

})

dispatcher.register (payload) ->
	if payload.actionType == "set-destUrl"
		FrameStore.setDestUrl(payload.attributes)