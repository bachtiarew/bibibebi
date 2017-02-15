ParentChildProfileMobile = React.createClass
	getInitialState: ->
		parent: ParentStore.parent
		detailChild: ParentStore.parent.child[0]

	onClickChild: (child) ->
		@setState(detailChild: child)

	render: ->
		{ parent } = @state

		ikonChild = (child, key) ->
			<div className="col-md-3">
				<div className="frame-child" onClick={@onClickChild.bind(this, child)}>
					<img src={child.picture_url.url} />
				</div>
			</div>

		<div className="container">
			<h4>Bibibebi</h4>
			<div className="parent-child-profile-mobile">
				<div className="row">
					<div className="col-sm-4">
						<div className="frame"><img src={picture_url.url} /></div>
					</div>
					<div className="col-sm-8">
						<table className="table text-right">
							<tbody>
								<tr><td><h3>{firstname} {lastname}</h3></td></tr>
								<tr><td><h4>{phone_number}</h4></td></tr>
								<tr><td>{address}</td>
								<tr></tr>
							</tbody>
						</table>
					</div>
				</div>
				<div className="row">
					{childs.map(child)}
				</div>
				<ChildProfile child={detailChild}/>
			</div>
		</div>

ChildProfile = React.createClass

	render: ->
		{ child } = @props
		{ name, age, gender, picture, description } = child
		<div className="profile-child">
			<div className="row">
				<div className="col-md-4">
					<div className="child-detail-frame">
						<img src={picture.picture_url.url} />
					</div>
				</div>
				<div className="col-md-8">
					<table className="table">
						<tbody>
						<tr><td>{name}</td></tr>
						<tr><td>{gender}, {age}</td></tr>
						<tr><td><p>{description}</p></td></tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

window.ParentChildProfileMobile = ParentChildProfileMobile
