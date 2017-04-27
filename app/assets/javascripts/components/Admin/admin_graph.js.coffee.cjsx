DATA = [
		{date: "Jan-17", invoice: 100, order: 200},
		{date: "Feb-17", invoice: 300, order: 100},
		{date: "Mar-17", invoice: 115, order: 50},
		{date: "Apr-17", invoice: 200, order: 200},
		{date: "May-17", invoice: 400, order: 350},
		{date: "Jun-17", invoice: 315, order: 250},
		{date: "Jul-17", invoice: 75, order: 550},
		{date: "Aug-17", invoice: 120, order: 255},
		{date: "Sep-17", invoice: 650, order: 550},
		{date: "Oct-17", invoice: 350, order: 355},
		{date: "Nov-17", invoice: 125, order: 450},
		{date: "Dec-17", invoice: 400, order: 400}
	]

AdminGraph = React.createClass

	getInitialState: ->
		data: DATA

	componentDidMount: ->
		{ data } = @state

		style = {}
		style.width = 1200
		style.id = "bibibebi-graph"
		style.color = "bar"

		margin = top: 40, right: 40, bottom: 40, left: 40
		width = style.width - margin.left - margin.right
		height = 400 - margin.top - margin.bottom
		yFormat = d3.format(".2s")

		parseTime = d3.timeParse("%b-%y")

		x = d3.scaleBand().range([0, width]).padding(0.1)
		x1 = d3.scaleTime().range([55, width - 55])
		y = d3.scaleLinear().range([height, 0])
		y1 = d3.scaleLinear().range([height, 0])

		valueLine = d3.line().x((d) -> x1(d.date)).y((d) -> y1(d.order))

		xAxis = d3.axisBottom().scale(x)
		x1Axis = d3.axisTop().scale(x1)
		yAxis = d3.axisLeft().scale(y)
		y1Axis = d3.axisRight().scale(y1)


		svg = d3.select("##{style.id}").append("svg").attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr('transform',"translate(#{margin.left},#{margin.top})")
		arrData = data.map((d) -> d.invoice)
		arrData1 = data.map((d) -> d.order)
		lineData = []

		_.forEach(data, (d) ->
			lineData.push({date: parseTime(d.date), order: +d.order})
		)
			
		x.domain(data.map((d) -> d.date))
		x1.domain(d3.extent(lineData, (d) -> d.date))
		y.domain([0, d3.max(arrData)])
		y1.domain([0, d3.max(arrData1)])

		svg.append('g').attr('class','x axis').attr('transform',"translate(0, #{height})").attr('height',300).call(xAxis)
		svg.append('g').attr('class','y axis').call(yAxis)
		svg.append('g').attr('class', 'y axis').attr("transform", "translate(#{width}, 0)").call(y1Axis)

		svg.selectAll(".bar").data(data).enter().append('rect').attr("class", style.color).attr('x',(d)-> x(d.date)).attr('width',x.bandwidth()).attr('y',(d) -> y(d.invoice)).attr('height',(d) -> height - y(d.invoice))

		svg.append("path").data([lineData]).attr("class", "line").attr("d", valueLine)

	render: ->
		<div id="bibibebi-graph" />


window.AdminGraph = AdminGraph