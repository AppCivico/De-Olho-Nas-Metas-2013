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

		//configurando o acordeon nas páginas de ação
		$('.acao-acordeon .panel-group').collapse({
			toggle: false
		});
});
