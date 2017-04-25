{EventEmitter} = fbemitter

CHANGE_EVENT = 'change'

window.ParentStore = _.assign(new EventEmitter(), {
	parent: {}
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

	setChilds: (arrObj) ->
		_.forEach(arrObj, (e) -> 
			@childs.push(e)
		)

		ParentStore.emitChange()

	removeItem: (childItem) ->
		childItem = _.find(@childs, (_item) -> _item.key == childItem.key)
		childItem._destroy = 1
		@emitChange()

	emitChange: ->
		console.log("harusnya kena emit")
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
	else if payload.actionType == 'set-parent'
		_.assign(ParentStore.parent, payload.parent)
		_.assign(ParentStore.parent, payload.pictures)
		ParentStore.setChilds(payload.childs)
		ParentStore.emitChange()
	else if payload.actionType == "set-parent-only"
		parent = {ortu: {}}
		_.assign(parent, payload.parent)
		ParentStore.parent = parent.ortu
		ParentStore.emitChange()

