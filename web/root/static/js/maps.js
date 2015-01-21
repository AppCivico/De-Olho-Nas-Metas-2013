var $maps = function () {
    var map,
    	infoBubble,
    	addr,
    	geocoder;

    function initialize() {
		var mapOptions = {
			center: new google.maps.LatLng(-23.549035, -46.634438),
			zoom: 16,
		};
		geocoder = new google.maps.Geocoder();

   	    map = new google.maps.Map(document.getElementById("map"),mapOptions);
    }

	function loadproject(){
		var ib;

		$.getJSON('/home/project_map',function(data,status){
			var json = data;
			$.each(json, function(i, pj){
				marker = "";
				var myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
	                url: pj.url
        	    });
				var url = marker.url;
				var content = '<div class="project-bubble"><div class="name">';
				content += pj.name + '</div>';
				content += '<div class="description"></div>';
				content += '<a class="link" href="' + url + '">Veja mais</a>';
				content += '</div>';
				google.maps.event.addListener(marker, 'click', function() {
					if (!ib){
						ib = new InfoBubble({
				          map: map,
				          content: content,
				          shadowStyle: 0,
				          padding: 10,
				          backgroundColor: 'rgb(255,255,255)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#fff',
				          disableAutoPan: true,
				          hideCloseButton: false,
				          arrowPosition: 50,
				          arrowStyle: 0,
				          MaxWidth: 340,
				          MinHeight: 100
				        });
				        ib.open(map, this);
					}else{
						ib.setContent(content);
						//ib.setPosition(myLatlng);
						ib.open(map, this);
					}
					console.log(marker);
					
        			//window.location.href = url;
    			});
			});
		});
	
	}
	function markprojectdetail( project_id ){
		$.getJSON('/home/project_map_single', { id : project_id } ,function(data,status){
			var json = data;d
			marker = "";
			var myLatlng = new google.maps.LatLng(json.latitude,json.longitude);	
			marker = new google.maps.Marker({
                position: myLatlng,
	            map: map,
				title: json.name,
				url : "/home/project/"+json.id
            });
			var url = marker.url;
			google.maps.event.addListener(marker, 'click', function() {
				if (!infoBubble){
					infoBubble = new InfoBubble({
			          map: map,
			          content: '<div class="project-bubble">' + json.name + '</div>',
			          position: myLatlng,
			          shadowStyle: 0,
			          padding: 10,
			          backgroundColor: 'rgb(57,57,57)',
			          borderRadius: 0,
			          arrowSize: 15,
			          borderWidth: 0,
			          borderColor: '#ffffff',
			          disableAutoPan: true,
			          hideCloseButton: false,
			          arrowPosition: 50,
			          backgroundClassName: 'project-bubble',
			          arrowStyle: 0
			        });
				}else{
					infoBubble.close();
				}
				infoBubble.open(map, marker);
        		//window.location.href = url;
    		});
			if (myLatlng){
				map.setCenter(myLatlng);
		    	map.setZoom(16);
			}
		});
	
	}
	function markregiondetail( region_id ){
		$.getJSON('/home/region_project', { id : region_id } ,function(data,status){
			var json = data;
			var myLatlng;
			$.each(json.projects, function(i, pj){
			marker = "";
			console.log(pj);
			myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
			marker = new google.maps.Marker({
                position: myLatlng,
	            map: map,
				title: pj.name,
				url : "/home/project/"+pj.id
            });
			var url = marker.url;
			google.maps.event.addListener(marker, 'click', function() {
        		window.location.href = url;
    		});
			});
			if (myLatlng){
				map.setCenter(myLatlng);
		    	map.setZoom(12);
			}
      });	
	}
	function markgoaldetail( goal_id ){
		$.getJSON('/home/project_map_list', { id : goal_id } ,function(data,status){
			$.each(data.project, function(i, pj){
				marker = "";
				var myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);
				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
					title: pj.name,
					url : "/home/project/"+pj.id
        	    });
				var url = marker.url;
				google.maps.event.addListener(marker, 'click', function() {
        			window.location.href = url;
    			});
			});

		    	map.setZoom(8);
		});
	
	}

	function codeAddress(data){
		geocoder.geocode({ 'address': data + ', Brasil', 'region': 'BR' }, function (results, status) {
                 return results;
		});
	}
	
	function setlocal(location){
		map.setCenter(location);
	    map.setZoom(16);
	}

	return {
		initialize	      : initialize,
		loadproject       : loadproject,
		codeAddress       : codeAddress,
		setlocal          : setlocal,
		markprojectdetail : markprojectdetail,
		markgoaldetail    : markgoaldetail,
		markregiondetail  : markregiondetail
	};
}();

$(document).ready(function () {
	if ($("#pagetype").val() !== 'homeregion'){
		$maps.initialize();
	}
	if ($("#pagetype").val() == 'home'){	
		$maps.loadproject();
	}		
	if ($("#pagetype").val() == 'homegoal'){	
		$maps.loadproject();
	}		
	if ($("#pagetype").val() == 'projectdetail'){	
		$maps.markprojectdetail($("#projectid").val());
	}		
	if ($("#pagetype").val() == 'goaldetail'){
		$maps.markgoaldetail($("#goalid").val());
	}		
	if ($("#pagetype").val() == 'regiondetail'){
		$maps.markregiondetail($("#regionid").val());
	}		
	$("#type").change(function(){
		var id = $( "#type option:selected" ).val();
     	$.get("/home/project/type",{type_id: id}).done( function(data){
			document.getElementById("result").innerHTML=data
       	});
	});

	$("#type_goal").change(function(){
		var id = $( "#type_goal option:selected" ).val();
     	$.get("/home/goal/type",{type_id: id}).done( function(data){
			document.getElementById("result").innerHTML=data
       	});
	});

	$("#homeregion").change(function(){
		var id = $( "#homeregion option:selected" ).val();
     	$.get("/home/project/region",{region_id: id}).done( function(data){
			document.getElementById("result").innerHTML=data
       	});
	});

	$("#goalregion").change(function(){
		var id = $( "#goalregion option:selected" ).val();
     	$.get("/home/goal/region",{region_id: id}).done( function(data){
			document.getElementById("result").innerHTML=data
       	});
	});

	$("#txtaddress").autocomplete({
	source: function (request, response) {
	   geocoder = new google.maps.Geocoder();
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
		if ($("#pagetype").val() == 'home'){		
 			$.get("/home/project/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				document.getElementById("result").innerHTML=data
        	});
        	$maps.setlocal(location);
		}
		if ($("#pagetype").val() == 'projectdetail'){		
 			$.get("/home/project/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				document.getElementById("result").innerHTML=data
        	});
		}
		
		if ($("#pagetype").val() == 'homegoal'){		
 			$.get("/home/goal/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				document.getElementById("result").innerHTML=data
        	});
		}

		if ($("#pagetype").val() == 'goaldetail'){		
 			$.get("/home/goal/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				document.getElementById("result").innerHTML=data
        	});
		}

		if ($("#pagetype").val() == 'homeregion'){		
			$.getJSON('/home/region/id',{latitude: ui.item.latitude, longitude: ui.item.longitude},function(data,status){
				console.log(data.error);
				if (data.message){
					document.getElementById("result").innerHTML="<h2 class=\"section-tittle\">"+data.message+"</h2>"
				}else{
					window.location.href="/home/region/"+data.id;
				}
        	});
		}
		if ($("#pagetype").val() == 'regiondetail'){			
 			$.get("/home/region/id",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				window.location.href="/home/region/"+data.id;
        	});
		}
			
    }
    });


});
