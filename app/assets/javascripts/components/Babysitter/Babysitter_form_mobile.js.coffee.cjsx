AttachmentFile = React.createClass
	
	getInitialState: ->
		attachmentSrc: ""

	onChangeSelectedInput: (event) ->
		attachment = event.target.files[0]
		formData = new FormData()
		formData.append("picture", attachment)

		url = URL.createObjectURL(attachment)
		@setState(attachmentSrc: url)

	onSelectedPicture: ->
		$("#babysitter-photo").click()

	render: ->
		{ pictures } = @props
		{ attachmentSrc } = @state

		<div className="text-center thumbnail-avatar">
			<a href="javascript:void(0)" style={width: "100%", fontSize: "14px", marginBottom: "20px"} className="btn btn-md" onClick={@onSelectedPicture}>
				<strong>Unggah Photo Profil</strong>
			</a>
			<input type="file" id="babysitter-photo" className="hidden" name="babysitter[picture_url]" onChange={@onChangeSelectedInput} />
			{
				pictureUrl = if (attachmentSrc != "" && attachmentSrc != null) then attachmentSrc else pictures[0].picture_url.picture_url.url
	
				if (attachmentSrc != "" && attachmentSrc != null) || !_.isEmpty(pictures)
					<img src={pictureUrl} className="image-preview" />		
			}
		</div>

BabysitterFormMobile = React.createClass
	propTypes:
		csrf_token: React.PropTypes.string

	getInitialState: ->
		user: BabysitterFormMobileStore.user
		babysitter: BabysitterFormMobileStore.babysitter
		skills: BabysitterFormMobileStore.skills
		formSkillShow: false
		editMode: BabysitterStore.editMode

	componentDidMount: ->
		BabysitterFormMobileStore.addChangeListener(@onChange)

	componentWillUnmount: ->
		BabysitterFormMobileStore.removeChangeListener(@onChange)

	onChange: ->
		@setState(
			user: BabysitterFormMobileStore.user
			babysitter: BabysitterFormMobileStore.babysitter
			skills: BabysitterFormMobileStore.skills
		)
	
	matched: (skill) ->
		{ babysitter } = @state
		{ babysitter_skills } = babysitter
		unless _.isEmpty(babysitter_skills)
			_.find(babysitter_skills, (e) ->
				if e.id == skill.id then true else false
			)
		else
			return false

	onCheckService: (skill) ->
		dispatcher.dispatch
			actionType: "babysitter-form-change-skills"
			skill: skill

	formSkill: ->
		{ skills } = @state
		arrIkonSkill = ["fa-user", "fa-leaf", "fa-star", "fa-bath", "fa-user"]

		skill = (e, key) =>
			skillName = "babysitter[skill_ids][]"
			skillClassName = classNames("fa " + arrIkonSkill[key] + " fa-2x")

			matched = @matched(e) 

			<tr key={key} className="skill-box" onClick={@onCheckService.bind(this, e)}>
				<td>
					<input type="checkbox" value={e.id} name={skillName} checked={matched} />
				</td>
				<td><i className={skillClassName}></i></td>
				<td>{e.name}</td>
				<td className="description">{e.description}</td>
			</tr>
		
		<table className="background-blue">
			{ skills.map(skill) }
		</table>	
		 
	onClickService: ->
		@setState(formSkillShow: !@state.formSkillShow)

	getAttachmentCache: (attachments, type) ->
	    unless _.isEmpty(attachments)
	      attachments.map (a) ->
	        if type == "image"
	          a.picture_url_cache
	        else
	          a.document_cache

	changeBabysitter: (attributes) ->
		dispatcher.dispatch
			actionType: "babysitter-form-change-babysitter"
			attributes: attributes

	onChangeNik: (event) ->
		@changeBabysitter({nik: event.target.value})

	onChangeFirstname: (event) ->
		console.log("firstname", event.target.value)
		@changeBabysitter({firstname: event.target.value})

	onChangeLastname: (event) ->
		@changeBabysitter({lastname: event.target.value})

	onChangeBornplace: (event) ->
		@changeBabysitter({bornplace: event.target.value})

	onChangeBorndate: (event) ->
		@changeBabysitter({borndate: event.target.value})

	onChangeGender: (event) ->
		@changeBabysitter({gender: event.target.value})

	onChangePhoneNumber: (event) ->
		@changeBabysitter({phone_number: event.target.value})

	onChangeAge: (event) ->
		@changeBabysitter({age: event.target.value})
	
	onChangeAdress: (event) ->
		@changeBabysitter({address: event.target.value})

	onChangePrice: (event) ->
		@changeBabysitter({price: event.target.value})

	onChangeDescription: (event) ->
		@changeBabysitter({description: event.target.value})

	render: ->
		{ csrf_token } = @props
		{ user, babysitter, skills, formSkillShow, editMode} = @state
		{ nik, age, pictures, description, price, firstname, lastname, borndate, bornplace, gender, address, phone_number } = babysitter
		 
		<div className="container text-center babysitter-mobile">
			<h4 className="logo">Bibibebi</h4>
			<div className="header">
				<i className="fa fa-blind"></i>
				<p style={color: "lightblue", fontSize: "14px"}>Mengisi Kelengkapan Data</p>
			</div>
			<div className="body">
				<div className="box-complete-data">
					<div className="form-group">
						<input type="text" className="form-control" name="babysitter[nik]" value={nik} placeholder="No Identitas" required={true} onChange={@onChangeNik} />
					</div>
					<div className="form-group">
						<input type="text" className="form-control" name="user[firstname]" value={firstname} placeholder="Nama Depan" required={true} onChange={@onChangeFirstname} />
					</div>
					<div className="form-group">
						<input type="text" className="form-control" name="user[lastname]" value={lastname} placeholder="Nama Belakang" required={true} onChange={@onChangeLastname} />
					</div>
					<div className="form-group">
						<input type="text" className="form-control" name="user[bornplace]" value={bornplace} placeholder="Tempat lahir" required={true} onChange={@onChangeBornplace} />
					</div>
					<div className="form-group">
						<input type="date" className="form-control" name="user[borndate]" value={borndate} placeholder="DD-MM-YYYY" required={true} onChange={@onChangeBorndate} />
					</div>
					<div className="form-group">
						<select className="form-control" value={gender} name="user[gender]" required={true} onChange={@onChangeGender} >
							<option value="male">Pria</option>
							<option value="female">Wanita</option>
						</select>
					</div>
					<div className="form-group">
						<input type="number" className="form-control" name="user[phone_number]" value={phone_number} placeholder="No Telepon" required={true} onChange={@onChangePhoneNumber} />
					</div>
					<div className="form-group">
						<input type="number" className="form-control" value={age} name="babysitter[age]" placeholder="Usia" required={true} onChange={@onChangeAge} />
					</div>
					<div className="form-group">
						<div className="col-xs-12">	
							<AttachmentFile pictures={pictures} />
						</div>
					</div>
					<div className="form-group">
						<div className="col-xs-12">
							{
								if false
									<AttachmentForm attrName="babysitter[document]"
									  inputName="document"
									  attachmentType="file"
									  carrierwaveCaches={@getAttachmentCache(documents, "file)")}
									  initialAttachments={documents}
									  displayLabel="Unggah File Pendukung" />
								else
									<a href="javascript:void(0)" style={width: "100%", fontSize: "14px", marginBottom: "20px"} className="btn btn-md" disabled={true}>
										<strong>Unggah File Pendukung</strong>
									</a>
							}
						</div>
					</div>
					<div className="form-group">
						<textarea className="form-control" name="user[address]" value={address} placeholder="Ketik disini alamat rumah anda" required={true} onChange={@onChangeAddress} />
					</div>
					<div className="form-group">
						<a href="javascript:void(0)" style={width: "100%"} className="btn btn-md" onClick={@onClickService}>
							<strong>Layanan Extra</strong>
						</a>
						{
							if formSkillShow == true
								@formSkill()
						}
					</div>
					<div className="form-group">
						<input type="number" className="form-control" name="babysitter[price]" value={price} placeholder="Harga" required={true} onChange={@onChangePrice} />
					</div>
					<div className="form-group">
						<textarea type="text" className="form-control" rows=5 name="babysitter[description]" value={description} placeholder="ketik disini deskripsi diri anda" required={true} onChange={@onChangeDescription} />
					</div>
					<div className="form-group">
						<button type="submit" className="btn btn-lg">
							{if editMode then "Ubah Profil" else "Lanjut"}
						</button> 
					</div>
					<input type="hidden" name="authenticity_token" value={csrf_token} />
				</div>
			</div>
		</div>

window.BabysitterFormMobile = BabysitterFormMobile