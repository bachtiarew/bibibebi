Modal = React.createClass
	
	getInitialState: ->
		error : null
		passwordValidation: null
		passwordConfirmValidation: null
		passwordValidationColor: null
		passwordConfirmValidationColor: null

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

	inputChange: ->
		data = @getParamsSignUp()
		dispatcher.dispatch
			actionType: "set-user-data"
			user: data
		dispatcher.dispatch
			actionType: "set-requesting"
			attributes: {
				type: "signUp"
				status: false
				submitting: true
			}


	checkRequired: (data) ->
		{firstname, bornplace, borndate, gender, phone_number,
			address, email, password, password_confirmation} = data
		if firstname == "" || bornplace == "" || borndate == "" || gender == "" || phone_number == "" || address == "" || email == "" || password == "" && password_confirmation == ""			
			return false
		else
			return true 
		
	submitFormSignUp: ->
		user = {}
		user = @getParamsSignUp()
		dispatcher.dispatch
			actionType: "set-user-data"
			user: user
		if @checkRequired(user)
			$.ajax(
				url: "/users"
				type: "post"
				data: JSON.stringify(user)
				contentType: "application/json"
				beforeSend: ->
					dispatcher.dispatch
						actionType: "set-requesting"
						attributes: {
							type: "signUp"
							status: true
							submitting: false
						}
				success: (payload) ->
					if payload.error
						@setState(
							@state.error = payload.error
						)
						
			)
		else 
			dispatcher.dispatch
				actionType: "set-requesting"
				attributes: {
					type: "signUp"
					status: false
					submitting: true
				}

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
					attributes: {
						type: "signIn"
						status: true
					}
			success: ->
				
		)	

	closeModal: ->
		@clearForm()
		@setState(
			passwordValidation: null
			passwordConfirmValidation: null
			passwordValidationColor: null
			passwordConfirmValidationColor: null
		)
		
		dispatcher.dispatch
			actionType: "close-modal"
			status: @props.status
		dispatcher.dispatch
				actionType: "set-requesting"
				attributes: {
					type: null
					status: false
					submitting: false
				}

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

	passwordOnChange: ->
		passwordValue = @refs.password.value
		passLength = passwordValue.length
		if passLength != 0
			if  passLength <= 5 
				message = "password lemah"
				messageColor = "weak"
			else if passLength >5 && passLength <= 10 
				message = "password sedang"
				messageColor = "normal"
			else if passLength > 10 
				message = "password kuat" 
				messageColor = "strong"
			@setState(
				passwordValidation: message
				passwordValidationColor: messageColor
			)
		else
			@setState(
				passwordValidation: null
				passwordValidationColor: null
			)

	passwordConfirmValidationOnChange: ->
		password = @refs.password.value
		confirm = @refs.passwordConfirm.value

		if confirm != null && confirm != ""
			if confirm == password
				message = "password cocok"
				messageColor = "strong"
			else
				message = "password tidak cocok"
				messageColor = "weak"

			@setState(
				passwordConfirmValidation: message
				passwordConfirmValidationColor: messageColor
			)
		else
			@setState(
				passwordConfirmValidation: null
				passwordConfirmValidationColor: null
			)
		
	render: ->
		{status, modal, user, requesting} = @props
		{passwordValidation, passwordConfirmValidation, 
		 passwordValidationColor, passwordConfirmValidationColor, error} = @state
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

		passwordValidationClass = classNames(passwordValidationColor)
		passwordConfirmValidationClass = classNames(passwordConfirmValidationColor)
		console.log("user", user.firstname)
		console.log("submitting", requesting.submitting)
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
					<button type="button" className="btn btn-sm btn-info" onClick={@submitLogin} disabled={if requesting.status == true && requesting.type == "signIn" then true else false}>
						{if requesting.status == true && requesting.type == "signIn" then "Proses Autentikasi.." else "Masuk"}
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
							<input id="firstname" type="text" className="form-control" placeholder="Masukan Nama Depan Anda" onChange={@inputChange} />
							<p className="text-right weak">
							{
								if requesting.submitting == true && user.firstname == ""
									"kolom ini wajib di isi"
							}
							</p>	
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
									<input id="gender" type="radio" name="gender" value="male" />Male
									</label>
								</div>
							</div>
							<div className="col-sm-6">
								<div className="radio">
									<label>
									<input id="gender" type="radio" name="gender" value="female" />Female
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
							<input type="password" id="password" ref="password" className="form-control"  onChange={@passwordOnChange} placeholder="Password" required/>
							<p className={passwordValidationClass}>{passwordValidation}</p>
							<input type="password" id="password_confirmation" ref="passwordConfirm" className="form-control top" onChange={@passwordConfirmValidationOnChange} placeholder="konfirmasi Password" required/>
							<p className={passwordConfirmValidationColor}>{passwordConfirmValidation}</p>
						</div>
						<div className="text-center">
							{if error
								<a href="javascript:void(0)" className="alert alert-danger">{error}</a>
							}
						</div>
					</div>
				</div>
				<div className="panel-footer">
					<div className="col-sm-6 text-left">
						<a href="javascript:void(0)" className="btn btn-sm btn-info" onClick={@submitFormSignUp} disabled={if requesting.status == true && requesting.type == "signUp" then true else false} >
							{if requesting.status == true && requesting.type == "signUp" then "Pendaftaran sedang di proses..." else "Mendaftar" }
						</a>
					</div>
					<div className="col-sm-6 text-right">
						<a href="javascript:void(0)" className="btn btn-sm btn-warning modal-close" onClick={@closeModal}>Tutup</a>
					</div>
				</div>
			</div>
		</div>


window.Modal = Modal