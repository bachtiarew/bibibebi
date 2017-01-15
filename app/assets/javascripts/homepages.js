$(document).ready(function(){
	$(window).scroll(function(){
		if($(this).scrollTop()>500){
			$("#img1").hide();
			$("#img2").show();
			
		}else{
			$("#img1").show();
			$("#img2").hide();
		}
		
	});
})
