	function carregarNoMapa(endereco) {
        geocoder.geocode({ 'address': endereco + ', Brasil', 'region': 'BR' }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[0]) {
                    var latitude = results[0].geometry.location.lat();
                    var longitude = results[0].geometry.location.lng();
 
                    $('#txtaddress').val(results[0].formatted_address);
                    $('#txtLatitude').val(latitude);
                    $('#txtLongitude').val(longitude);

 					$.get("/project/region_by_cep",{latitude: latitude, longitude: longitude}).done( function(data){
						document.getElementById("result").innerHTML=data
        		 	});

                    var location = new google.maps.LatLng(latitude, longitude);
					var mapOptions = {
					center: new google.maps.LatLng(location),
					zoom: 16,
					};

                    map.setCenter(location);
                    map.setZoom(16);
                }
            }
        });
    }

function initialize() {
		var marker;
		var mapOptions = {
			center: new google.maps.LatLng(-23.549035, -46.634438),
			zoom: 16,
		};
		geocoder = new google.maps.Geocoder();

   	    map = new google.maps.Map(document.getElementById("map"),mapOptions);
		$.getJSON('/project_map',function(data,status){
			var json = data;
			$.each(json, function(i, pj){
				marker = "";
				var myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
					title: pj.name,
					url : "/project/"+pj.id
        	    });

				google.maps.event.addListener(marker, 'click', function() {
        			window.location.href = marker.url;
    			});
			});
		});
      }
	
	
$(document).ready(function(){
		
		var geocoder;
		var marker;

		initialize();

		if ($('#listprojects').length){	
		var marker;
		var mapOptions = {
			center: new google.maps.LatLng(-23.549035, -46.634438),
			zoom: 8,
		};
   	    map = new google.maps.Map(document.getElementById("listprojects"),mapOptions);
		$.getJSON('/project_map_list', { id : [%goal_obj.id ? goal_obj.id : 0 %] },function(data,status){
			var json = data;
			$.each(json, function(i, pj){
				marker = "";
				var myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
					title: pj.name,
					url : "/project/"+pj.id
        	    });

				google.maps.event.addListener(marker, 'click', function() {
        			window.location.href = marker.url;
    			});
			});
		});

		}
		$("#type").change(function(){
			var id = $( "#type option:selected" ).val();
  	     	$.get("/project/type",{type_id: id}).done( function(data){
				document.getElementById("result").innerHTML=data
         	});
		});
		$("#region").change(function(){
			var id = $( "#region option:selected" ).val();
  	     	$.get("/project/region",{region_id: id}).done( function(data){
				document.getElementById("result").innerHTML=data
         	});
		});
		$("#txtaddress").autocomplete({
        source: function (request, response) {
            geocoder.geocode({ 'address': request.term + ', Brasil', 'region': 'BR' }, function (results, status) {
                response($.map(results, function (item) {
                    return {
                        label: item.formatted_address,
                        value: item.formatted_address,
                        latitude: item.geometry.location.lat(),
                        longitude: item.geometry.location.lng()
                    }
                }));
            })
        },
        select: function (event, ui) {
            var location = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
						
 			$.get("/project/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				document.getElementById("result").innerHTML=data
        	});
            map.setCenter(location);
            map.setZoom(16);
        }
    });

	$("#btnaddress").click(function() {
        if($(this).val() != "")
            carregarNoMapa($("#txtaddress").val());
    });
 
    $("#txtaddress").blur(function() {
        if($(this).val() != "")
            carregarNoMapa($(this).val());
    });
});
