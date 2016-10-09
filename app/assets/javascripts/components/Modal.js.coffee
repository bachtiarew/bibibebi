Modal = React.createClass

	getParamsSignUp: ->
		data = {}
		data.firstname = document.getElementById("firstname").value
		data.lastname = document.getElementById("lastname").value
		data.bornplace = document.getElementById("bornplace").value 
		data.borndate = document.getElementById("borndate").value
		data.gender = document.getElementById("gender").value 
		data.address = document.getElementById("address").value 
		data.phone_number = document.getElementById("phone_number").value 
		data.email = document.getElementById("email").value 
		data.password = document.getElementById("password").value 
		data.password_confirmation = document.getElementById("password_confirmation").value 
		data.role = @props.status
		data

	getParamsLogin: ->
		data = {}
		data.email = document.getElementById("email-login").value
		data.password = document.getElementById("password-login").value
		data
		
	submitFormSignUp: ->
		user = {}
		user = @getParamsSignUp()
		console.log("iam submit sign up", user)
		dispatcher.dispatch
			actionType: "set-user-data"
			user: user

		$.ajax(
			url: "/users"
			type: "post"
			data: JSON.stringify(user)
			contentType: "application/json"
			beforeSend: ->
				dispatcher.dispatch
					actionType: "set-requesting"
			success:  ->
				console.log("send ajax sign up success")
		)


	submitLogin: ->
		user = {}
		user = @getParamsLogin()
		dispatcher.dispatch
			actionType: "set-user-data"
			user: user
		$.ajax(
			url: "/users/login"
			type: "post"
			data: JSON.stringify(user)
			contentType: "application/json"
			beforeSend: ->
				dispatcher.dispatch
					actionType: "set-requesting"
			success: ->
				console.log("send login data has been success")
				
		)	

	closeModal: ->
		@clearForm()
		dispatcher.dispatch
			actionType: "close-modal"
			status: @props.status

	clearForm: ->
		document.getElementById("firstname").value = ""
		document.getElementById("lastname").value = ""
		document.getElementById("bornplace").value = ""
		document.getElementById("borndate").value = ""
		document.getElementById("address").value = ""
		document.getElementById("phone_number").value = ""
		document.getElementById("email").value = ""
		document.getElementById("password").value = ""
		document.getElementById("password_confirmation").value = ""
		document.getElementById("email-login").value = ""
		document.getElementById("password-login").value = ""


	render: ->
		{status, modal, user, requesting} = @props

		overlayClass = classNames("overlay",
			{"hide": (modal == false)},
			{"show": (modal == true)}
			)

		panelClass = classNames("signup panel panel-default",
			{"hide": (modal == false)},
			{"show": (modal == true && status != "login")}
			)
		
		FormLoginClass = classNames("login panel panel-default",
			{"hide": (modal == false)},
			{"show": (modal == true && status == "login")}
			)

		header = if status == "parent" then "Orang Tua" else "Pengasuh"
		<div>
			<div className={overlayClass} onClick={@closeModal}></div>
			<div className={FormLoginClass} >
				<div className="panel-heading text-center">Masuk</div>
				<div className="panel-body">
					<div clasName="form-group">
						<label>Email</label>
						<input id="email-login" type="email" className="form-control" placeholder="Email" />
					</div>
					<div clasName="form-group">
						<label>Password</label>
						<input id="password-login" type="password" className="form-control" placeholder="Password" />
					</div>
					<div className="form-group text-right">
						<div className="checkbox">
						<label>
						<input type="checkbox" value=false />
						Ingatkan Saya</label>
						</div>
					</div>
				</div>
				<div className="panel-footer">
					<div className="col-sm-6 text-left">
					<button type="button" className="btn btn-sm btn-info" onClick={@submitLogin} disabled={if requesting == true && status == "login" then true else false}>
						{if requesting == true && status == "login" then "Proses Autentikasi.." else "Masuk"}
					</button>
					</div>
					<div className="col-sm-6 text-right">
						<button type="submit" className="btn btn-sm btn-warning" onClick={@closeModal}>Tutup</button>
					</div>
				</div> 
			</div>
			<div className={panelClass}>
				<div className="panel-heading text-center">Mendaftar {header}</div>
				<div className="panel-body text-left">
					<div className="col-sm-4">
						<div className="form-group">
							<label>Nama Depan</label>
							<input id="firstname" type="text" className="form-control" placeholder="Masukan Nama Depan Anda" />
						</div>
						<div className="form-group">
							<label>Nama Akhir</label>
							<input type="text"  id="lastname" className="form-control" placeholder="Masukan Nama Akhir Anda" />
						</div>
						<div className="form-group">
							<label>Tempat & Tgl Lahir</label>
							<input type="text" id="bornplace" className="form-control" placeholder="Place your born" required/>
							<input type="date" id="borndate" className="form-control top" placeholder="YYYY-MM-DD" />
						</div>
					</div>
					<div className="col-sm-4 form-border">
						<div className="form-group">
							<div>
								<label>Gender</label>
							</div>
							<div className="col-sm-6">
								<div className="radio">
									<label>
									<input id="gender" type="radio" value="male" />Male
									</label>
								</div>
							</div>
							<div className="col-sm-6">
								<div className="radio">
									<label>
									<input id="gender" type="radio"  value="female" />Female
									</label>
								</div>
							</div>
						</div>
						<div className="form-group">
							<label>No Telepon</label>
							<input type="number" id="phone_number" className="form-control" placeholder="No Telepon anda" />
						</div>
						<div className="form-group">
							<label>Alamat</label>
							<textarea id="address" className="form-control" rows=5 placeholder="Ketik disini..." />
						</div>
					</div>
					<div className="col-sm-4">
						<div className="form-group">
							<label>Email</label>
							<input type="email" id="email" className="form-control" placeholder="Masukan email anda" required/>
						</div>
						<div className="form-group">
							<label>Password</label>
							<input type="password" id="password" className="form-control" placeholder="Password" required/>
							<input type="password" id="password_confirmation" className="form-control top" placeholder="konfirmasi Password" required/>
						</div>
					</div>
				</div>
				<div className="panel-footer">
					<div className="col-sm-6 text-left">
						<a href="javascript:void(0)" className="btn btn-sm btn-info" onClick={@submitFormSignUp} disabled={if requesting == true && status != "login" then true else false} >
							{if requesting == true && status != "login" then "Pendaftaran sedang di proses..." else "Mendaftar" }
						</a>
					</div>
					<div className="col-sm-6 text-right">
						<a href="javascript:void(0)" className="btn btn-sm btn-warning modal-close" onClick={@closeModal}>Tutup</a>
					</div>
				</div>
			</div>
		</div>


window.Modal = Modal