Modal = React.createClass
	setModal: ->
		dispatcher.dispatch
			actionType: 'set-modal'
			status: @props.status

	submitSignUp: ->
		dispatcher.dispatch
			actionType: "submit-sign-up"

	closeModal: ->
		dispatcher.dispatch
			actionType: "set-modal"
			status: @props.status

	render: ->
		{status, modal} = @props
	
		overlayClass = classNames("overlay") 

		panelClass = classNames(
			"panel panel-default",
			{"show": (modal == true)},
			{"hide": (modal == false)}
			)

		header = if status == "parent" then "Orang Tua" else "Pengasuh"
		<div>
			<div className={overlayClass} onClick={@setModal}></div>
			<div className={panelClass}>
				<div className="panel-heading text-center">Mendaftar {header}</div>
				<div className="panel-body text-left">
					<div className="col-sm-4">
						<div className="form-group">
							<label>Nama Depan</label>
							<input type="text" className="form-control" name="#{status}[:first_name]" placeholder="Masukan Nama Depan Anda" />
						</div>
						<div className="form-group">
							<label>Nama Akhir</label>
							<input type="text" className="form-control" name="#{status}[:last_name]" placeholder="Masukan Nama Akhir Anda" />
						</div>
						<div className="form-group">
							<label>Tempat & Tgl Lahir</label>
							<input type="text" className="form-control" name="#{status}[:bornplace]" placeholder="Place your born" required/>
							<input type="date" className="form-control top" name="#{status}[:borndate]" placeholder="YYYY-MM-DD" />
						</div>
					</div>
					<div className="col-sm-4">
						<div className="form-group">
							<label>No Telepon</label>
							<input type="number" className="form-control" name="#{status}[:phone_number]" placeholder="No Telepon anda" />
						</div>
						<div className="form-group">
							<label>Alamat</label>
							<textarea className="form-control" name="#{status}[:address]" rows=5 placeholder="Ketik disini..." />
						</div>
					</div>
					<div className="col-sm-4 form-border">
						<div className="form-group">
							<label>Email</label>
							<input type="email" className="form-control" name="#{status}[:email]" placeholder="Masukan email anda" required/>
						</div>
						<div className="form-group">
							<label>Password</label>
							<input type="password" className="form-control" name="#{status}[:password]" placeholder="Password" required/>
							<input type="password" className="form-control top" name="#{status}[:password_confirmation" placeholder="konfirmasi Password" required/>
						</div>
					</div>
				</div>
				<div className="panel-footer">
					<div style={float: "left"}>
						<a href="javascript:void(0)" className="btn btn-sm btn-info" onClick={@submitSignUp}>Mendaftar</a>
					</div>
					<div style={float: "right"}>
						<a href="javascript:void(0)" className="btn btn-sm btn-warning modal-close" onClick={@closeModal}>Tutup</a>
					</div>
				</div>
			</div>
		</div>


window.Modal = Modal