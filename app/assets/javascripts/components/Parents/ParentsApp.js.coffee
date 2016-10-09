FormChild = React.createClass

	getInitialState: ->
		{
			ChildItems: ParentStore.getChilds()
		}

	componentDidMount: ->
		ParentStore.addChangeListener(@_onChange)

	componentWillUnmount: ->
		ParentStore.removeChangeListener(@_onChange)	

	render: ->
		{clickAddItemChild} = @
		{ChildItems} = @state
		ChildItems ||= []
		console.log("state child items",@state.ChildItems)
		FormComponentItems = (childItem) ->
			console.log("index child item", childItem.key)
			index = childItem.key || childItem._index
			<FormChildItems childItem={childItem} key={childItem.key} index={index}/>

		<div className="table-responsive">
			<table className="table">
				<thead>
					<tr>
 						<th>Name</th>
 						<th>Gender</th>
 						<th>Age</th>
 						<th>Description</th>
 						<th>#</th>
 					</tr>
				</thead>
				<tbody>
					{ChildItems.map(FormComponentItems)}
				</tbody>
			</table>
			<div className="form-group text-right">
				<button type="button" onClick={clickAddItemChild} className="btn btn-sm btn-success">Add</button>
			</div>
		</div>

	clickAddItemChild: (event) ->
		event.preventDefault()
		dispatcher.dispatch({ actionType: 'child-item-add-blank' })
	
	_onChange: ->
		@setState(ChildItems: ParentStore.getChilds())

FormChildItems = React.createClass
	
	propTypes:
		childItem: React.PropTypes.object.isRequired
		index: React.PropTypes.number.isRequired

	RemoveItem: (event) ->
		event.preventDefault()
		console.log("run remove item")
		dispatcher.dispatch({ 
			actionType: 'child-item-remove'
			childItem: @props.childItem
		})

	render: ->

		{childItem, index} = @props
		ParentNamePrefix = "parent"
		ChildNamePrefix = "#{ParentNamePrefix}[child_items][]"
		NameChildName = "#{ChildNamePrefix}[name]"
		GenderChildName = "#{ChildNamePrefix}[gender]"
		AgeChildName = "#{ChildNamePrefix}[age]"
		DescriptionChildName = "#{ChildNamePrefix}[description]"
		idHiddenInputName = "#{ChildNamePrefix}[id]"
		
		if childItem._destroy == 1
			destroyInputName = "#{ChildNamePrefix}[_destroy]"
			destroyHiddenInput = <input name={destroyInputName} value=1 className="form-control" type="hidden" />
			hiddenAttribut = { display: 'none' }
		else
			hiddenAttribut = {}

		<tr style={hiddenAttribut} >
			{destroyHiddenInput}
			<input name={idHiddenInputName} value={index} className="form-control" type="hidden" />
			<td><input type="text"  name={NameChildName} className="form-control"/></td>
			<td>
				<select  name={GenderChildName} className="form-control">
					<option value="male">Male</option>
					<option value="female">Female</option>
				</select>
			</td>
			<td><input name={AgeChildName} type="number" className="form-control"/></td>
			<td>
				<textarea  name={DescriptionChildName} className="form-control" rows="4"/>
			</td>
			<td><button type="button" onClick={@RemoveItem} className="Btn btn-danger btn-sm">x</button></td>
		</tr>


FormParents = React.createClass 
	render: ->
		<div>			
			<div className="form-group">
				<label className="sr-only" for="inputfile">Photos</label>
					<input type="file" name="parent[photos]" id="parent_photos"/>
					<p className="help-block">Example block-level help text-here</p>
			</div>
			<FormChild/>
			<div className="form-group">
				<button type="submit" className="btn btn-md btn-info">Submit</button>
			</div>
		</div>

UserProfile = React.createClass
	getInitialState: ->
		users: {}

	load_users: ->
		that = @
		$.ajax
			method: 'get'
			url: 'get_user'
			dataType: "JSON"
			contentType: "application/json"
			success: (response) ->
				that.setState users: response
				return

	componentDidMount: ->
		@load_users()
		return
		
	render: ->
		<div className="Well">
			<h3>{@state.users.firstname} {@state.users.lastname}</h3>
			<h5>{@state.users.gender}</h5>
			<h5>{@state.users.bornplace}</h5>
			<h5>{@state.users.borndate}</h5>
			<h5>{@state.users.address}</h5>
			<h5>{@state.users.phonenumber}</h5>
		</div>


ParentsApp = React.createClass
	render: ->
		<div className="container-fluid">
		<UserProfile />
		<FormParents />
		</div>


window.ParentsApp = ParentsApp