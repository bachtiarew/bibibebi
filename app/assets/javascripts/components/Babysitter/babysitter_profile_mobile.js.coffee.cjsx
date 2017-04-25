BabysitterProfileMobile = React.createClass
	
	getInitialState: ->
		babysitter: BabysitterStore.babysitter
		currentUser: @props.current_user
		editMode: BabysitterStore.editMode
		formAuthenticityToken: BabysitterStore.formAuthenticityToken

	componentDidMount: ->
		BabysitterStore.addChangeListener(@onChange)

	componentWillUnmount: ->
		BabysitterStore.removeChangeListener(@onChange)

	onChange: ->
		@setState(
			babysitter: BabysitterStore.babysitter
			editMode: BabysitterStore.editMode
			formAuthenticityToken: BabysitterStore.formAuthenticityToken
		)

	getBackUrl: ->
		{ currentUser } = @state
		url = if currentUser.role == "parent" then "/parents" else "/babysitters"
		window.location = url 

	onClickEditMode: ->
		{ babysitter } = @state

		window.location = "/babysitters/" + babysitter.id + "/edit.html?mobile=true"		
		

	render: ->
		{ csrf_token } = @props
		{ babysitter, currentUser, editMode, formAuthenticityToken } = @state
		{ firstname, lastname, bornplace, borndate, address, phone_number, email, 
		price, age, nik, pictures, description, babysitter_skills, avgRate } = babysitter
		
		avgRate = if avgRate?.avg then avgRate.avg else 0
		urlBackToHome = if currentUser.role == "parent" then "/parents" else "/babysitters"

		buttonStyle={border: "2px solid #fff", borderRadius: "0px" ,margin: "5px 10px 5px 10px", backgroundColor: "#00112b"}

		editUrl = "/babysitters/" + babysitter.id

		if editMode 
			<form  action={editUrl} method="PATCH">
				<BabysitterFormMobile csrf_token={csrf_token} />
			</form>
		else
			<div className="container babysitter-profile-mobile text-center">
				<h4 className="logo">Bibibebi</h4>
				<div className="body">
					<div className="row">
						<div className="col-xs-4">
							<div className="frame"><img src={pictures[0].picture_url.picture_url.url} /></div>
						</div>
						<div className="col-xs-8">
							<table className="table text-right">
								<tbody>
									<tr><td colSpan="2" style={fontSize: "22px"}>Rp.{price} K</td></tr>
									<tr><td>{firstname} {lastname}</td><td>{age} Thn</td></tr>
									<tr>
										<td colSpan="2">
											{
												if currentUser.role == "parent"
													<div className="rate-babysitter">
													</div>
												else if currentUser.role == "babysitter"
													<RatingAverage avgRate={parseInt(avgRate)} />
											}
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div className="row">
						<div className="col-xs-6">
							<table className="table text-left">
								<tbody>
									<tr>
										<td><i className="fa fa-circle fa-1x"></i></td>
										<td>{nik}</td>
										<td></td>
									</tr>
									<tr>
										<td><i className="fa fa-circle fa-1x"></i></td>
										<td>{bornplace}, {borndate}</td>
										<td></td>
									</tr>
									<tr>
										<td><i className="fa fa-circle fa-1x"></i></td>
										<td>{phone_number}</td>
										<td></td>
									</tr>
									<tr>
										<td><i className="fa fa-circle fa-1x"></i></td>
										<td colSpan="2">{address}</td>
									</tr>
									<tr>
										<td><i className="fa fa-circle fa-1x"></i></td>
										<td colSpan="2"><textarea style={width: "250px"} rows="5" value={description} disabled="true" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<BabysitterSkillsMobile skills={babysitter_skills} />
				</div>
				{
					if currentUser.role == "babysitter"
						<button style={buttonStyle} className="btn btn-md" onClick={@onClickEditMode}>
							<i className="fa fa-gear fa-1x" /> Edit Profile 
						</button>
				}
				<button style={buttonStyle} onClick={@getBackUrl} className="btn btn-md">
					<i className="fa fa-home"></i> Kembali ke Beranda
				</button>
			</div>

BabysitterSkillsMobile = React.createClass

	getInitialState: ->
		skills: @props.skills
		skillIcon: BabysitterStore.skillIcon
		showDetailSkill: true
		detailSkill: @props.skills[0]

	getIcon: (skill) ->
		{ skillIcon } = @state
		iconSkill = _.find(skillIcon, (e) -> e.id == skill.id)
		
		<i className={iconSkill.iconClassName}></i>

	onClickDetailSkill: (skill) ->
		@setState(showDetailSkill: true, detailSkill: skill)

	onHide: ->
		@setState(showDetailSkill: false)

	render: ->
		{ skills, detailSkill, showDetailSkill } = @state
		

		skill = (skill, key) =>
			skillFrameClassName = classNames( "skill-frame",
				{"visited" : skill.id == detailSkill?.id}
			)

			<div key={key} className="col-xs-3 text-center">
				<div className={skillFrameClassName} onClick={@onClickDetailSkill.bind(this, skill)}>
					{@getIcon(skill)}
				</div>
			</div>
		
		<div>
			<div style={padding: "0px 10px 10px 10px"} className="row text-center">
				{
					if skills.length > 0
						skills.map(skill)
					else
						<div className="col-xs-3 text-center">
							<div className="skill-frame">
								<i className="fa fa-user fa-2x"></i>
							</div>
						</div>
				}
			</div>
			{
				if showDetailSkill == true
					<div className="detail-skill">
						<table className="table text-left">
							<tbody>
								<tr>
									<td><label>Score:</label></td>
									<td><strong>{detailSkill.score}</strong></td>
									<td><label>Layanan:</label></td>
									<td><strong>{detailSkill.name}</strong></td>
								</tr>
								<tr><td colspan="4"><label>Description:</label></td></tr>
								<tr>
									<td colSpan="4">
										<p>{detailSkill.description}</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
			}
		</div>

RatingAverage = React.createClass	

	getInitialState: ->
		avgRate: @props.avgRate  

	getDefaultProps: ->
		heightStyle: null

	generateStar: ->
		{ heightStyle } = @props
		{ avgRate } = @state
		avgRate = if avgRate == null || avgRate == undefined then 0 else avgRate
		console.log("avgRate", avgRate)

		ratingStyle = if heightStyle then {color: "#00112b", height: heightStyle } else {color: "#00112b"}

		star = (full, half, blank) ->
			<div className="babysitter-rating" style={ratingStyle}>
				{	
					unless full == 0
						for i in [1..full]
							<i key={"full" + i} className="fa fa-star fa-1x"></i>
				}
				{
					unless half == 0
						for i in [1..half]
							<i key={i} className="fa fa-star-half fa-1x"></i>
				}
				{	
					unless blank == 0
						for i in [1..blank]
							<i key={i} className="fa fa-star-o fa-1x"></i>
				}
			</div>

		halfStar = if avgRate % 1 == 0 then 0 else 1
		fullStar = Math.ceil(avgRate)
		blankStar = 5 - Math.ceil(avgRate)
		blankStar = blankStar - 1 if halfStar > 0

		star(fullStar, halfStar, blankStar)

	render: ->
		@generateStar()		

window.BabysitterProfileMobile = BabysitterProfileMobile