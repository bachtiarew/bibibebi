dispatcher.dispatch
	actionType: "set-parent"
	parent: <%= @parent.to_json.html_safe %>
	childs: <%= @childs.to_json.html_safe %>
	pictures: <%=  @parent_pictures.to_json.html_safe %>