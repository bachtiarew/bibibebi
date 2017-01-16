BabysitterFormMobile = React.createClass
	propTypes:
		csrf_token: React.PropTypes.string

	getInitialState: ->

	componentDidMount: ->

	componentWillUnmount: ->

	render: ->
		<div className="container babysitter-mobile">
			<h4>Bibibebi</h4>
			<div className="header">
				<i className="fa fa-blind"></i>
				<p style={color: "lightblue", fontSize: "14px"}>Mengisi Kelengkapan Data</p>
			</div>
			<div className="body">
				<div className="box-complete-data">
					<form type="post" action="">
						<div className="form-group">
							<input type="text" className="form-control"  name="user[firstname]" placeholder="Nama Depan" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control" name="user[lastname]" placeholder="Nama Belakang" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control" name="user[bornplace]" placeholder="Tempat lahir" />
						</div>
						<div className="form-group">
							<input type="date" className="form-control" name="user[borndate]" placeholder="DD-MM-YYYY" />
						</div>
						<div className="form-group">
							<select className="form-control" name="user[gender]">
								<option value="male">Male</option>
								<option value="female">Female</option>
							</select>
						</div>
						<div className="form-group">
							<textarea classname="form-control" rows={7} name="user[address]" placeholder="ketik disini"></textarea>
						</div>
						<hr />
						<div className="form-group">
							<input type="text" className="form-control" name="babysitter[nik]"placeholder="No Identitas" />
						</div>
						<div className="form-group">
							<input type="number" className="form-control" name="babysitter[age]" placeholder="Usia" />
						</div>
						<div className="form-group">
							<select multiple className="form-control" name="babysitter[][skill]">
								<option value="PartTime">Part Time</option>
								<option value="FullTime">Full Time</option>
								<option value="HouseKeeping">House Keeping</option>
								<option value="PrivateLearning">Private Learning</option>
								<option value="skill-E">Skill E</option>
								<option value="skill-F">Skill F</option>
							</select>
						</div>
						<div className="form-group">
							<input type="file" enctype="multiple" name="babysitter[pictures]" />
						</div>
						<div className="form-group">
							<input type="file" enctype="multiple" name="babysitter[documents]" />
						</div>
						<div className="form-group">
							<button type="submit" className="btn btn-lg">Lanjut</button> 
						</div>
					</form>
				</div>
			</div>
		</div>

window.BabysitterFormMobile = BabysitterFormMobile