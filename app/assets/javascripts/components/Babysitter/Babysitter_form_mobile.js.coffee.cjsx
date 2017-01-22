AttachmentFile = React.createClass
	
	getInitialState: ->
		attachmentSrc: ""

	onChangeSelectedInput: (event) ->
		attachment = event.target.files[0]
		formData = new FormData()
		formData.append("picture", attachment)

		url = URL.createObjectURL(attachment)
		@setState(attachmentSrc: url)

	render: ->
		{ attachmentSrc } = @state

		<div className="text-center thumbnail-avatar">
			<input type="file" className="form-control" name="babysitter[picture_url]" onChange={@onChangeSelectedInput} />
			{
				if attachmentSrc == "" || attachmentSrc == null
					<div className="image-preview">	
						<i className="fa fa-picture"></i>
					</div>
				else
					<img src={attachmentSrc} className="image-preview" />		
			}
			<input type="hidden" name="babysitter[remote_picture_url_url]" value={attachmentSrc} />
		</div>

BabysitterFormMobile = React.createClass
	propTypes:
		csrf_token: React.PropTypes.string

	getInitialState: ->
		user: BabysitterFormMobileStore.user
		babysitter: BabysitterFormMobileStore.babysitter
		skills: BabysitterFormMobileStore.skills
		formSkillShow: false

	componentDidMount: ->
		BabysitterFormMobileStore.addChangeListener(@onChange)

	componentWillUnmount: ->
		BabysitterFormMobileStore.removeChangeListener(@onChange)

	matched: (skill) ->
		{ babysitter } = @state
		{ babysitter_skills } = babysitter
		unless _.isEmpty(babysitter_skills)
			_.find(babysitter_skills, (e) -> 
				if e.id == skill.id then true else false
			)
		else
			return false

	formSkill: ->
		{ skills } = @state
		arrIkonSkill = ["fa-user", "fa-leaf", "fa-star", "fa-bath", "fa-user"]

		skill = (e, key) =>
			skillName = "babysitter[skill_ids][]"
			skillClassName = classNames("fa " + arrIkonSkill[key] + " fa-2x")

			matched = @matched(e) 

			<tr key={key} className="skill-box" onClick={@onCheckService}>
				<td><input type="checkbox" value={e.id} name={skillName} checked={matched} /></td>
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

	render: ->
		{ csrf_token } = @props
		{ user, babysitter, skills, formSkillShow } = @state
		{ firstname, lastname, borndate, bornplace, gender, address, phone_number } = user
		{ nik, age, pictures, description, price } = babysitter
		 
		<div className="container text-center babysitter-mobile">
			<h4 className="logo">Bibibebi</h4>
			<div className="header">
				<i className="fa fa-blind"></i>
				<p style={color: "lightblue", fontSize: "14px"}>Mengisi Kelengkapan Data</p>
			</div>
			<div className="body">
				<div className="box-complete-data">
					<form method="post" action="/babysitters/create_mobile">
						<div className="form-group">
							<input type="text" className="form-control" name="babysitter[nik]" value={nik} placeholder="No Identitas" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control"  name="user[firstname]" value={firstname} placeholder="Nama Depan" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control" name="user[lastname]" value={lastname} placeholder="Nama Belakang" />
						</div>
						<div className="form-group">
							<input type="text" className="form-control" name="user[bornplace]" value={bornplace} placeholder="Tempat lahir" />
						</div>
						<div className="form-group">
							<input type="date" className="form-control" name="user[borndate]" value={borndate} placeholder="DD-MM-YYYY" />
						</div>
						<div className="form-group">
							<select className="form-control" value={gender} name="user[gender]">
								<option value="male">Pria</option>
								<option value="female">Wanita</option>
							</select>
						</div>
						<div className="form-group">
							<input type="number" className="form-control" name="user[phone_number]" value={phone_number} placeholder="No Telepon"/>
						</div>
						<div className="form-group">
							<input type="number" className="form-control" value={age} name="babysitter[age]" placeholder="Usia" />
						</div>
						<div className="form-group">
							<div className="col-xs-12">
							{
								if false
									<AttachmentForm attrName="babysitter[picture]"
					                  inputName="picture_url"
					                  attachmentType="image"
					                  carrierwaveCaches={@getAttachmentCache(pictures, "image")}
					                  initialAttachments={pictures}
					                  displayLabel="Unggah Foto Profil" />
								else
									<AttachmentFile />
							}
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
							<textarea className="form-control" name="user[address]" value={address} placeholder="Ketik disini alamat rumah anda" />
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
							<input type="number" className="form-control" name="babysitter[price]" value={price} placeholder="Harga" />
						</div>
						<div className="form-group">
							<textarea type="text" className="form-control" rows=5 name="babysitter[description]" value={description} placeholder="ketik disini deskripsi diri anda" />
						</div>
						<div className="form-group">
							<button type="submit" className="btn btn-lg">Lanjut</button> 
						</div>
						<input type="hidden" name="authenticity_token" value={csrf_token} />
					</form>
				</div>
			</div>
		</div>

window.BabysitterFormMobile = BabysitterFormMobile