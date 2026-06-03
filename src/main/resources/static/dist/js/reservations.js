$(function(){
	
	
	
	
	$(".tabWrap .tab").click(function(){
		
		let idx = $(this).index();
		
		$(".tab").removeClass("on");
		$(this).addClass("on");
		
		$(".listWrap > div").hide();
		$(".listWrap > div").eq(idx).show();
		
		
	});
	
	
});