ProfileMobile = React.createClass
	
	getInitialState: ->
		currentUser: ProfileMobileStore.currentUser
		parent: ProfileMobileStore.parent
		babysitter: ProfileMobileStore.babysitter
		iconSkills: ProfileMobileStore.iconSkills
		skillChoosed: ProfileMobileStore.skillChoosed
		kidChoosed: ProfileMobileStore.kidChoosed
		navbarUrl: ProfileMobileStore.navbarUrl

	componentDidMount: ->
		ProfileMobileStore.addChangeListener(@onChange)

	componentWillUnmount: ->
		ProfileMobileStore.removeChangeListener(@onChange)

	onChange: ->
		@setState(
			currentUser: ProfileMobileStore.currentUser
			parent: ProfileMobileStore.parent
			babysitter: ProfileMobileStore.babysitter
			skillChoosed: ProfileMobileStore.skillChoosed
			kidChoosed: ProfileMobileStore.kidChoosed
		)

	onClickSkillChoosed: (skill) ->
		dispatcher.dispatch
			actionType: "profile-mobile-store-set-babysitter-skill-choosed"
			skillChoosed: skill

	onClickGoToUrl: (indexNavbar) ->
		{ navbarUrl, babysitter, currentUser, parent } = @state
		
		if currentUser.role == "babysitter"
			url = if indexNavbar == 1 then navbarUrl.babysitter[indexNavbar] + babysitter.id + "?mobile=true" else navbarUrl.babysitter[indexNavbar]
		else if currentUser.role == "parent"
			url = if indexNavbar == 1 then navbarUrl.parent[indexNavbar] + parent.id + "?mobile=true" else navbarUrl.parent[indexNavbar]
		
		window.location = url
	
	getIconSkillType: (skill) ->
		{ iconSkills } = @state
		iconClassName = _.find(iconSkills, (s) -> s.id == skill.id)?.icon
		<i className={iconClassName} />

	babysitterDisplay: ->
		{ babysitter, skillChoosed } = @state
		{ pictures, babysitter_skills, firstname, lastname, gender, age, avgRate, phone_number, address, description, bornplace, borndate, price } = babysitter

		babysitterSkill = (skill, key) =>
			babysitterSkillClassName = classNames( "babysitter-skill-frame"
				{"active" : skillChoosed.id == skill.id },
				{"not-active" : skillChoosed.id != skill.id}
			)
			<div className={babysitterSkillClassName} onClick={@onClickSkillChoosed.bind(@, skill)}>
				{@getIconSkillType(skill)}
			</div>

		<div id="profile-mobile" className="container text-center profile-mobile" >
			<h4 className="logo">Bibibebi</h4>
			<div className="mainpage-mobile-navbar">
				<div className="row">
					<div className="col-xs-2 col-xs-offset-1">
						<div className="menu-frame">
							<i className="fa fa-home" onClick={@onClickGoToUrl.bind(@, 0)} />
						</div>
					</div>
					<div className="col-xs-2">
						<div className="menu-frame active">
							<i className="fa fa-user" onClick={@onClickGoToUrl.bind(@, 1)} />
						</div>
					</div>
					<div className="col-xs-2">
						<div className="menu-frame">
							<i className="fa fa-book" onClick={@onClickGoToUrl.bind(@, 2)} />
						</div>
					</div>
					<div className="col-xs-2">
						<div className="menu-frame">
							<i className="fa fa-shopping-cart" onClick={@onClickGoToUrl.bind(@, 3)} />
						</div>
					</div>
					<div className="col-xs-2">
						<div className="menu-frame">
							<i className="fa fa-commenting" onClick={@onClickGoToUrl.bind(@, 4)} />
						</div>
					</div>
				</div>
			</div>
			<div className="mainpage-list">
				<div className="parent-row not-active">
					<div className="row">
						<div className="col-xs-3">
							<img src={pictures[0].picture_url.picture_url.url} />
						</div>
						<div className="col-xs-9">
							<table className="table">
								<thead>
									<tr><th className="text-big">{firstname} {lastname}</th></tr>
									<tr><th className="text-small">{gender}, {age} Tahun</th></tr>
									<tr>
										<th className="text-small">
											<RatingAverage heightStyle="25px" avgRate={avgRate} />
										</th>
									</tr>
								</thead>
							</table>					
						</div>
					</div>
				</div>
				<div className="row">
					<div className="col-xs-10">
						<div className="detail-information text-left">
							<p><strong><u>Tempat, Tanggal Lahir</u></strong></p>
							<p>{bornplace}, {borndate}</p>
							<p/>
							<p><strong><u>Alamat</u></strong></p>
							<p>{address}</p>
							<p/>
							<p><strong><u>Deskripsi</u></strong></p>
							<p>{description}</p>
							<p/>
							<p/>
							<p style={fontSize: "20px"} className="text-right"><strong>Rp.{price * 1000},00</strong></p>
						</div>
					</div>
					<div style={padding: "0px 0px 0px 0px"} className="col-xs-2 text-center">
						<div className="babysitter-skill-list">
							{babysitter_skills.map(babysitterSkill)}
						</div>
					</div>
				</div>
				<div className="row">
					<div className="col-xs-12">
						<p/>
						<p style={color: "lightblue"} className="text-right"><strong><u>Detail Layanan</u></strong></p>
						<div className="detail-skill text-left">
							<p><strong>{skillChoosed.name}</strong></p>
							<p>{skillChoosed.description}</p>
						</div>
					</div>
				</div>
				<ProfileMobileActionButton />
			</div>
		</div>

	parentDisplay: ->	
		{ parent } = @state
		{ pictures, firstname, lastname, gender, age, phone_number, address, description , bornplace, borndate, price } = parent

		<div id="profile-mobile" className="container text-center profile-mobile">
			<h4 className="logo">Bibibebi</h4>
			<div className="mainpage-mobile-navbar">
				<div className="row">
					<div className="col-xs-2 col-xs-offset-1">
						<div className="menu-frame">
							<i className="fa fa-home" />
						</div>
					</div>
					<div className="col-xs-2">
						<div className="menu-frame active">
							<i className="fa fa-user" />
						</div>
					</div>
					<div className="col-xs-2">
						<div className="menu-frame">
							<i className="fa fa-book" />
						</div>
					</div>
					<div className="col-xs-2">
						<div className="menu-frame">
							<i className="fa fa-shopping-cart" />
						</div>
					</div>
					<div className="col-xs-2">
						<div className="menu-frame">
							<i className="fa fa-commenting" />
						</div>
					</div>
				</div>
			</div>
		</div>


	render: ->
		{ currentUser } = @state

		if currentUser.role == "babysitter"
			@babysitterDisplay()

		else if currentUser.role == "parent"
			@parentDisplay()

ProfileMobileActionButton = React.createClass
	
	render: ->
		<div className="row profile-mobile-action-button">
			<div className="col-xs-12">
				<i className="fa fa-edit fa-2x" />
				<i className="fa fa-lock fa-2x" />
			</div>
		</div>


window.ProfileMobile = ProfileMobile		