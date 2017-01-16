ParentFormMobile = React.create.class
	getInitialState: ->

	componentDidMount: ->

	componentWillUnmount: ->

	render: ->
		<div className="container">
			<div className="header">
				<i className="fa fa-child"></i>
				<p style={color: "lightblue", fontSize: 16px}></p>
			</div>
			<div className="body">
				<div className="box-completed-data">
					<form type="post" action="" >
						<div className="form-group">
							<input type="text" className="form-control" />
						</div>
						<div className="form-group">
							<input type="number" className="form-control" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control" />
						</div>				
					</form>
				</div>
			</div>
		</div>

window.ParentFormMobile = ParentFormMobile