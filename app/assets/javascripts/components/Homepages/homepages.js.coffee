Footer = React.createClass
	render: ->
		<div className="footer">
			<h3>Footer</h3>
		</div>

Procedure = React.createClass
	render: ->
		<div className="container">
			<h3>Procedure</h3>
		</div>

Benefit = React.createClass
	render: ->
		<div className="container">
			<h3>Benefit</h3>
		</div>

Promo = React.createClass
	render: ->
		<div className="container">
			<div className="col-md-3">
				<h4>promo 1</h4>
			</div>

			<div className="col-md-3">
				<h4>promo 2</h4>
			</div>

			<div className="col-md-3">
				<h4>promo 3</h4>
			</div>

			<div className="col-md-3">
				<h4>promo 4</h4>
			</div>
		</div>

ImageContainer = React.createClass 
	render: ->
		<div className="imageBox">
			
		</div>

Menu = React.createClass
	
	setModalParent: ->
		status = "parent"
		dispatcher.dispatch
			actionType: "set-modal"
			status: status
	
	setModalBabysitter: ->
		status = "babysitter"
		dispatcher.dispatch
			actionType: "set-modal"
			status: status
		
	setModalLogin: ->
		status = "login"
		dispatcher.dispatch
			actionType: "set-modal"
			status: status

	render: ->
		<div className="row">
			<div className="col-sm-6 text-right">
				hanya disini proses aman dan nyaman 
			</div>
			<div className="col-sm-4 text-center">
				<div className="sign-up">
					Mendaftar <a href="javascript:void(0)" className="menuParent" onClick={@setModalParent} >Ortu</a> | <a href="javascript:void(0)" className="menuBabysitter" onClick={@setModalBabysitter}>Pengasuh</a>
				</div>
			</div>
			<div className="col-sm-2 text-left">
				<a href="javascript:void(0)" className="btn btn-sm btn-info" onClick={@setModalLogin} ><b>Login</b></a>
			</div>
		</div>

Brand = React.createClass 
	render: ->
		<div className="row">
			<div className="col-sm-5 text-right">
				Bibibebi
			</div>
			<div className="col-sm-7 text-left">
				solusi terbaik untuk sang buah hati
			</div>
		</div>

Header = React.createClass
	render: ->
		<div className="header">
			<div className="row box">
				<div className="col-sm-5 brand">
					<Brand/>
				</div>
				
				<div className="col-sm-7 menu">
					<Menu/>
				</div>
			</div>
		</div>

Homepages = React.createClass	

	getInitialState: ->
		status: null
		modal: false
		loginStatus: false
		requesting: false
		user: {}	

	componentDidMount: ->
		console.log("hello iam did mount")
		HomepageStore.createBlankForm()
		HomepageStore.status = null
		HomepageStore.modal = false
		HomepageStore.requesting = false
		HomepageStore.addChangeListener(@onChange)

	componentWillUnMount: ->
		HomepageStore.removeChangeListener(@onChange)

	onChange: ->
		console.log("hayo aku harus dipanggil")
		@setState(
			status: HomepageStore.status
			modal: HomepageStore.modal
			user : HomepageStore.user
			requesting: HomepageStore.requesting
		)

	render: ->
	  {status, modal, user,requesting} = @state
	  console.log("user homepage view",user)
	  <div className="container-fluid homepages">
	  	<Header/>
	  	<ImageContainer/>
	  	<Promo/>
	  	<Benefit/>
	  	<Procedure/>
	  	<Footer/>
	  	<Modal status={status}
	  			modal={modal}
	  			requesting={requesting}
	  			user={user}/>
	  			
	  </div>
  	

window.Homepages = Homepages
