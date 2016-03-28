$(document).ready(function () {
	$(".faq .item .question").click(function(e){
		$(this).parent().toggleClass("expanded");
	});

	$(".faq .expand-all").click(function(e){
		e.preventDefault();
		$(".faq .item").addClass("expanded");
	});
	$(".faq .collapse-all").click(function(e){
		e.preventDefault();
		$(".faq .item").removeClass("expanded");
	});
});