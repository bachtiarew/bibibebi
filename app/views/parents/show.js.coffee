dispatcher.dispatch
	actionType: "set-parent"
	parent: <%= @parentd.to_json.html_safe %>
	childs: <%= @childs.to_json.html_safe %>
	pictures: <%=  @parent_picture.to_json.html_safe %>