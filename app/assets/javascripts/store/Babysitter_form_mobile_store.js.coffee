{ EventEmitter } = fbemitter

CHANGE_EVENT = "change"

window.BabysitterFormMobileStore = _.assign(new EventEmitter(),{
	user: {} 
	babysitter: {}
	skills: []

	changeSkill: (skill) ->
		babysitterSkill = _.find(@babysitter.babysitter_skills, (e) -> e.id == skill.id)
		
		if babysitterSkill
			_.remove(@babysitter.babysitter_skills, (e) -> return e.id == skill.id)
		else 
			@babysitter.babysitter_skills.push(skill)

		@emitChange()

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

	else if payload.actionType == "babysitter-form-change-skills"
		BabysitterFormMobileStore.changeSkill(payload.skill)

	else if payload.actionType == "babysitter-form-change-babysitter"
		_.assign(BabysitterFormMobileStore.babysitter, payload.attributes)
		BabysitterFormMobileStore.emitChange()