ParentProfileMobile = React.createClass
	
	getInitialState: ->
		parent: ParentStore.parent
		currentUser: @props.current_user
		
	componentDidMount: ->
		ParentStore.addChangeListener(@onChange)

	componentWillUnmount: ->
		ParentStore.removeChangeListener(@onChange)

	onChange: ->
		@setState(
			parent: ParentStore.parent
		)

	getBackUrl: ->
		{ currentUser } = @state
		url = if currentUser.role == "parent" then "/parents" else "/babysitters"
		window.location = url 

	onClickEditMode: ->
		{ parent } = @state

		window.location = "/parents/" + parent.id + "/edit.html?mobile=true"		
		
	render: ->
		{ csrf_token } = @props
		{ parent, currentUser } = @state
		{ firstname, lastname, bornplace, borndate, address, phone_number, email, 
		price, age, nik, pictures, kids } = parent
		
		urlBackToHome = if currentUser.role == "parent" then "/parents" else "/babysitters"

		buttonStyle={border: "2px solid #fff", borderRadius: "0px" ,margin: "5px 10px 5px 10px", backgroundColor: "#00112b"}
	
		<div className="container parent-profile-mobile text-center">
			<h4 className="logo">Bibibebi</h4>
			<div className="body">
				<div className="row">
					<div className="col-xs-4">
						<div className="frame"><img src={pictures[0].picture_url.url} /></div>
					</div>
					<div className="col-xs-8">
						<table className="table text-right">
							<tbody>
								<tr><td>{firstname} {lastname}</td><td>{age} Thn</td></tr>
								<tr>
									<td colSpan="2">
										{phone_number}
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
									<td>{bornplace}, {borndate}</td>
									<td></td>
								</tr>
								<tr>
									<td><i className="fa fa-circle fa-1x"></i></td>
									<td colSpan="2">{address}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<ParentChilds childs={kids} />
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

ParentChilds = React.createClass

	getInitialState: ->
		childs: @props.childs
		showDetailChild: true
		detailChild: @props.childs[0]

	onClickDetailChild: (child) ->
		@setState(showDetailChild: true, detailChild: child)

	onHide: ->
		@setState(showDetailChild: false)

	render: ->
		{ childs, detailChild, showDetailChild } = @state
		
		child = (child, key) =>
			<div key={key} className="col-xs-3 text-center">
				<div className="child-frame" onClick={@onClickDetailChild.bind(this, childs)}>
					<img src={child.pictures[0].picture_url.url} />
				</div>
			</div>
		
		<div>
			<div style={padding: "0px 10px 10px 10px"} className="row text-center">
				{childs.map(child)}
			</div>
			{
				if showDetailChild == true
					<div className="detail-child">
						<div className="row">
							<div className="col-xs-4">
								<div className="child-photo-frame text-center">
									<img src={detailChild.pictures[0].picture_url.url} />
								</div>
							</div>
							<div className="col-xs-8">
								<table className="table text-right">
									<tbody>
										<tr>
											<td>
												<i className="fa fa-user" />
											</td>
											<td>{detailChild.name},{detailChild.gender}</td>
										</tr>
										<tr>
											<td>
												<i className="fa fa-user" />
											</td>
											<td>{detailChild.age} Tahun</td>
										</tr>
										<tr>
											<td colSpan="2">
												<label>Description</label>
											</td>
										</tr>
										<tr>
											<td colSpan="2">{detailChild.description}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>						
					</div>
			}
		</div>


window.ParentProfileMobile = ParentProfileMobile