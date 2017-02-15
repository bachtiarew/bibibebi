BabysitterProfileMobile = React.createClass
	getInitialState: ->
		babysitter: BabysitterStore.babysitter

	render: ->
		{ babysitter } = @state
		<div className="container">
			<h4 className="logo">Bibibebi</h4>
			<div className="babysitter-profile-mobile">
				<div className="row">
					<div className="col-sm-4">
						<div className="frame"><img src={picture_url.url} /></div>
					</div>
					<div className="col-sm-8">
						<table className="table text-right">
							<tbody>
								<tr><td colSpan="2"><h2>Rp.{price} K</h2></td></tr>
								<tr><td>{firstname} {lastname}</td><td>{age} Thn</td></tr>
								<tr><td><Rating /></td></tr>
								<tr></tr>
							</tbody>
						</table>
					</div>
				</div>
				<div className="row">
					<div className="col-md-6">
						<table className="table">
							<tbody>
								<tr>
									<td><i className="fa fa-chevron fa-1x"></i></td>
									<td>{nik}</td>
								</tr>
								<tr>
									<td><i className="fa fa-chevron fa-1x"></i></td>
									<td>{bornplace}, {borndate}</td>
								</tr>
								<tr>
									<td><i className="fa fa-chevron fa-1x"></i></td>
									<td>{phone_number}</td>
								</tr>
								<tr>
									<td><i className="fa fa-chevron fa-1x"></i></td>
									<td>{address}</td>
								</tr>
								<tr>
									<td><i className="fa fa-chevron fa-1x"></i></td>
									<td><textarea  rows="5" disabled={disabled}>{description}</textarea></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<BabysitterSkills skills={skills} />
			</div>
			{
				if user.role == "babysitter"
					<a href={Routes.babysitters_path} className="btn btn-md"><i className="fa fa-home"></i> Kembali ke Beranda<a>
				else
					<a href={Routes.parents_path} className="btn btn-md"><i className="fa fa-home"></i> Kembali ke Beranda</a>
			}
		</div>

BabysitterSkills = React.createClass
	propTypes:
		skills: React.PropTypes.array

	getInitialState: ->
		skills: @props.skills
		skillIcon: babysitterStore.skillIcon
		showDetailSkill: false
		detailSkill: {}

	getIcon: (skill) ->
		{ skillIcon } = @state
		iconSkill = _.find(skillIcon, (e) -> e.name == skill.name)
		<i className={iconSkill.iconClassName}></i>

	onClickDetailSkill: (skill) ->
		@setState(showDetailSkill: true, detailSkill: skill)

	onHide: ->
		@setState(showDetailSkill: false)

	render: ->
		{ skills, detailSkill, showDetailSkill } = @state

		skill = (skill, key) =>
			<div className="col-md-3">
				<div className="skill-frame" onClick={@onClickDetailSkill.bind(this, skill)}>
					@getIcon(skill)
				</div>
			</div>
		<div>
			<div className="row text-center">
				{skills.map(skill)}
			</div>
			{
				if showDetailSkill == true
					<div className="modal">
						<div className="modal-header">
							<button className="close" onClick={@onHide}>
								<span>x</span>
							</button>
							<div className="modal-title">
								Detail Skill
							</div>
						</div>
						<div className="modal-body">
							<p>{detailSkill.description}</p>
						</div>
						<div className="modal-fotter">
							<button className="btn btn-sm btn-default" onClick={@onHide}>
							Close</button>
						</div>
					</div>
			}
		</div>

window.BabysitterProfileMobile = BabysitterProfileMobile