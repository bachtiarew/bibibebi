dispatcher.dispatch({
	actionType: "set-babysitter",
	babysitter: <%= @babysitter.to_json.html_safe %>,
	babysitterSkills: <%= @skills.to_json.html_safe %>,
	pictures: <%= @pictures[0].to_json.html_safe %>,
	user: <%= @user.to_json.html_safe %>
})
	

$(document).ready(function(){
	$(".beforeRate").mouseover(function(){
		var scoreRate = $("i.beforeRate").index(this);
		var i = 0;

		while (i <= scoreRate) {
			$("i.beforeRate").eq(i).removeClass("fa-star-o")
			$("i.beforeRate").eq(i).addClass("fa-star")
			i++
		}
	})
	$("i.beforeRate").mouseout(function(){
		$('i.beforeRate').removeClass("fa-star")
		$("i.beforeRate").addClass("fa-star-o")
	})
});
