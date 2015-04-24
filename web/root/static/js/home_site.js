$(document).ready(function() {
	$.extend({
		scrollTo: function(id){
			if (id.charAt(0) != "." && id.charAt(0) != "#"){
				id = "#"+id;
			}			
			var top = $(id).offset().top - 108,
				target = "html,body";
			$(target).animate({scrollTop: top},'slow');
		}
		
	});
	
	$('.page-scroll a').bind('click', function(event) {
        var $anchor = $(this);
		console.log($($anchor.attr('href')).offset().top);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top - 108
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });	
	
	var iv;
	
	$(".image-gallery .arrow.left .glyphicon").mousedown(function(){
		var div = $(this).parent().parent().find(".contents");
		iv = setInterval(function(){
            div.scrollLeft( div.scrollLeft() - 4);
        },20);
	});
	$(".image-gallery .arrow.right .glyphicon").mousedown(function(){
		var div = $(this).parent().parent().find(".contents");
		iv = setInterval(function(){
            div.scrollLeft( div.scrollLeft() + 4);
        },20);
	});
	
	$('.image-gallery .arrow.left .glyphicon,.image-gallery .arrow.right .glyphicon').on('mouseup mouseleave', function(){
        clearInterval(iv);
    });

    $("#elm_request_council").click(function(e){
    	if ($(this).prop("checked")){
    		$(".council-list").show();
    	}else{
    		$(".council-list").hide();
    	}
    });
});
