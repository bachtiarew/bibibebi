{EventEmitter} = fbemitter

CHANGE_EVENT = 'change'

window.ParentStore = _.assign(new EventEmitter(), {
	childs: []

	getChilds: ->
		@childs

	addBlankItem: ->
		key = @generate_key()
		@childs.push({key: key, _destroy: 0 })
		@emitChange()

	generate_key: () ->
		len = @childs.length
		key = 0
		key += len

	removeItem: (childItem) ->
		childItem = _.find(@childs, (_item) -> _item.key == childItem.key)
		childItem._destroy = 1
		console.log("remove",childItem)
		@emitChange()

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) ->
		@addListener(CHANGE_EVENT, callback)

	removeChangeListener: ->
		@removeAllListener(CHANGE_EVENT)
		
})

dispatcher.register (payload) ->
	if payload.actionType == 'child-item-add-blank'
		ParentStore.addBlankItem(payload.childItem)
	else if payload.actionType == 'child-item-remove'
		ParentStore.removeItem(payload.childItem)

