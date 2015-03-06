var $maps = function () {
	if (!google.maps.Polygon.prototype.getBounds) {

        google.maps.Polygon.prototype.getBounds = function(latLng) {

                var bounds = new google.maps.LatLngBounds();
                var paths = this.getPaths();
                var path;
                
                for (var p = 0; p < paths.getLength(); p++) {
                        path = paths.getAt(p);
                        for (var i = 0; i < path.getLength(); i++) {
                                bounds.extend(path.getAt(i));
                        }
                }

                return bounds;
        }

	}
    var map,
    	infoBubble,
    	addr,
    	geocoder,
		mc,
		marker_array = [];

	function setAllMap(dado){
		for (var i = 0; i < marker_array.length; i++){
			marker_array[i].setMap(null);
		}
	}
	function clearMarkers(){
		setAllMap(null);
	}
	function deleteMarkers(){
		clearMarkers();
		marker_array = [];
		mc.clearMarkers();
	}

    function initialize() {
		var mapOptions = {
			center: new google.maps.LatLng(-23.549035, -46.634438),
			zoom: 10,
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
	                url: "/home/project/"+pj.id,
	                icon: "/static/images/icone_mapa.png"
        	    });
				marker_array.push(marker);
				var url = marker.url;
				var content = '<div class="project-bubble"><div class="name">';
				content += '<a href="' + url + '">';
				content += pj.name + '</a></div>';
				content += '<div class="description"></div>';
				content += '</div>';
				google.maps.event.addListener(marker, 'mouseover', function() {
					if (!ib){
						ib = new InfoBubble({
				          map: map,
				          content: content,
				          shadowStyle: 0,
				          padding: 0,
				          backgroundColor: 'rgb(140,198,63)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#8cc63f',
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
        			//window.location.href = url;
    			});
			});
			mc = new MarkerClusterer(map, marker_array);
			map.setZoom(12);
		});
	
	}

	function markprojectdetail( project_id ){
		var ib;
		var myLatlng;
		$.getJSON('/home/project_map_single', { id : project_id } ,function(data,status){
			var json = data;
			marker = "";
			var geojson = eval('(' + json.geom_json + ')');
            var polygon = new GeoJSON(geojson, 
			{
					  "strokeColor": "#FF7800",
				      "strokeOpacity": 1,
				      "strokeWeight": 2,
				      "fillColor": "#46461F",
				      "fillOpacity": 0.25 

			});
			
			latlong = polygon.getBounds().getCenter();

			myLatlng = new google.maps.LatLng(json.latitude,json.longitude);	
			polygon.setMap(map);	
			marker = new google.maps.Marker({
	                position: myLatlng,
		            map: map,
		            icon: "/static/images/icone_mapa.png"
	        });

			var url = marker.url;

			google.maps.event.addListener(polygon, "click", function(event) {

				var content = '<div class="project-bubble"><div class="name">';
				content += '<a href="' + url + '">';
				content += json.region.name + '</a></div>';
				content += '</div>';

				if (!ib){
		              ib = new InfoBubble({
			          map: map,
			          content: content,
	        	      shadowStyle: 0,
		        	  padding: 0,
			          backgroundColor: 'rgb(222,164,2)',
			          borderRadius: 0,
			          arrowSize: 15,
			          borderWidth: 0,
			          borderColor: '#dea402',
			          disableAutoPan: true,
			          hideCloseButton: false,
		    	      arrowPosition: 50,
	   	      	      arrowStyle: 0,
	   			      MaxWidth: 340,
	   	      		  MinHeight: 60
	   	    	  });
	       		  ib.open(map);
	       		  ib.setPosition(event.latLng);
				}else{
					ib.setContent(content);
					ib.setPosition(event.latLng);
					ib.open(map);
				}
			});


			if (myLatlng){
				map.setCenter(myLatlng);
		    	map.setZoom(12);
			}
		});
	
	}
	function showregions( ){
		var ib;
		var myLatlng;
		myLatlng = new google.maps.LatLng(-23.554070, -46.634438);	
		$.getJSON('/home/getregions', function(data,status){
			var json = data;
			//var infowindow = new google.maps.InfoWindow();
			$.each(json.geoms, function(i, pj){
				marker = "";
		    	var geojson = eval('(' + pj.geom_json + ')');
	            var polygon = new GeoJSON(geojson, 
					{
					  "strokeColor": "#FF7800",
				      "strokeOpacity": 1,
				      "strokeWeight": 2,
				      "fillColor": "#46461F",
				      "fillOpacity": 0.25 });

				marker = new google.maps.Marker({
		            map: map,
					url : "/home/region/"+pj.id,
	            });
				var url = marker.url;
				google.maps.event.addListener(polygon, "mouseover", function(event) {

					var content = '<div class="project-bubble" style="width: 300px;"><div class="name">';
					content += 'Distrito: <a href="' + url + '">';
					content += pj.name + '</a></div>';
					content += '<div class="name">';
					content += 'Subprefeitura: <a href="' + '/home/subprefecture/' +pj.subprefecture_id+ '">'+pj.subprefecture.name+'</a></div>';
					content += '</div>';

					if (!ib){
  		              ib = new InfoBubble({
				          map: map,
				          content: content,
		        	      shadowStyle: 0,
			        	  padding: 0,
				          backgroundColor: 'rgb(222,164,2)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#dea402',
				          disableAutoPan: true,
				          hideCloseButton: false,
			    	      arrowPosition: 50,
		   	      	      arrowStyle: 0,
		   			      MaxWidth: 340,
		   	      		  MinHeight: 120
		   	    	  });
		       		  ib.open(map);
		       		  ib.setPosition(event.latLng);
					}else{
						ib.setContent(content);
						ib.setPosition(event.latLng);
						ib.open(map);
					}

					/*infowindow.setContent(content);
					infowindow.setPosition(event.latLng);
					infowindow.open(map);*/
				});

				map.data.addListener('click', function(event) {
					    event.feature.setProperty('isColorful', true);
				});	
				polygon.getBounds().getCenter();
				polygon.setMap(map);	
				
			});
	    	map.setCenter(myLatlng);
	    	map.setZoom(10);
      });	
	}

	function markregiondetail( region_id ){
		var ib;
		$.getJSON('/home/region_project', { id : region_id } ,function(data,status){
			var json = data;
			var myLatlng;
			var geojson = eval('(' + json.geom_json + ')');
	        var polygon = new GeoJSON(geojson, 
			{
			  "strokeColor": "#FF7800",
			  "strokeOpacity": 1,
			  "strokeWeight": 2,
			  "fillColor": "#46461F",
			  "fillOpacity": 0.25 
			});

			polygon.setMap(map);	

			$.each(json.projects, function(i, pj){
				marker = "";
				myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
				marker = new google.maps.Marker({
	                position: myLatlng,
		            map: map,
					url : "/home/project/"+pj.id,
		            icon: "/static/images/icone_mapa.png"
	            });
				var url = marker.url;
				var content = '<div class="project-bubble"><div class="name">';
				content += '<a href="' + url + '">';
				content += pj.name + '</a></div>';
				content += '</div>';
				google.maps.event.addListener(marker, 'mouseover', function() {
					if (!ib){
						ib = new InfoBubble({
				          map: map,
				          content: content,
				          shadowStyle: 0,
				          padding: 0,
				          backgroundColor: 'rgb(140,198,63)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#8cc63f',
				          disableAutoPan: true,
				          hideCloseButton: false,
				          arrowPosition: 50,
				          arrowStyle: 0,
				          MaxWidth: 340,
				          MinHeight: 60
				        });
				        ib.open(map, this);
					}else{
						ib.setContent(content);
						//ib.setPosition(myLatlng);
						ib.open(map, this);
					}
	        		//window.location.href = url;
	    		});
			});
						
			var latlong = polygon.getBounds().getCenter();
			myLatlng = new google.maps.LatLng(latlong.k,latlong.D);	
			

			if (myLatlng){
				map.setCenter(myLatlng);
		    	map.setZoom(12);
			}
      });	
	}

	function markorgdetail( org_id ){
		$.getJSON('/home/subpref_org',{ id : org_id },function(data,status){
			var json = data;
			var myLatlng;
			var ib;
			var myLatlng = new google.maps.LatLng(data.subprefecture.latitude,data.subprefecture.longitude);	
				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
	                url: "/home/subprefecture/"+data.subprefecture.id,
	                icon: "/static/images/icone_mapa.png"
        	    });
				var url = marker.url;
				var content = '<div class="project-bubble" ><div class="name">';
				content += '<a href="/home/subprefecture/'+data.subprefecture.id+'">' + data.subprefecture.name + '</a></div>';
				content += '</div>';

				google.maps.event.addListener(marker, 'mouseover', function() {
					if (!ib){
						ib = new InfoBubble({
				          map: map,
				          content: content,
				          shadowStyle: 0,
				          padding: 0,
				          backgroundColor: 'rgb(140,198,63)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#8cc63f',
				          disableAutoPan: true,
				          hideCloseButton: false,
				          arrowPosition: 50,
				          arrowStyle: 0,
				          MaxWidth: 340,
				          MinHeight: 60
				        });
				        ib.open(map, this);
					}else{
						ib.setContent(content);
						ib.open(map, this);
					}
    			});

	   		map.setCenter(myLatlng);
		  	map.setZoom(12);	
        });	

	}

	function marksubprefdetail( subpref_id ){
		var ib;
		$.getJSON('/home/subpref_region', { id : subpref_id } ,function(data,status){
			var json = data;
			var myLatlng;
			$.each(json.regions, function(i, pj){
				marker = "";
		    	var geojson = eval('(' + pj.geom_json + ')');
	            var polygon = new GeoJSON(geojson, 
					{
					  "strokeColor": "#FF7800",
				      "strokeOpacity": 1,
				      "strokeWeight": 2,
				      "fillColor": "#46461F",
				      "fillOpacity": 0.25 });

				marker = new google.maps.Marker({
		            map: map,
					url : "/home/region/"+pj.id,
	            });
				var url = marker.url;

				google.maps.event.addListener(polygon, "mouseover", function(event) {

					var content = '<div class="project-bubble"><div class="name">';
					content += '<a href="' + url + '">';
					content += pj.name + '</a></div>';
					content += '</div>';
					if (!ib){
  		              ib = new InfoBubble({
				          map: map,
				          content: content,
		        	      shadowStyle: 0,
			        	  padding: 0,
				          backgroundColor: 'rgb(222,164,2)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#dea402',
				          disableAutoPan: true,
				          hideCloseButton: false,
			    	      arrowPosition: 50,
		   	      	      arrowStyle: 0,
		   			      MaxWidth: 340,
		   	      		  MinHeight: 60
		   	    	  });
		       		  ib.open(map);
		       		  ib.setPosition(event.latLng);
					}else{
						ib.setContent(content);
						ib.setPosition(event.latLng);
						ib.open(map);
					}
				});

				map.data.addListener('click', function(event) {
				    event.feature.setProperty('isColorful', true);
			    });	
				polygon.getBounds().getCenter();
				polygon.setMap(map);	
			
			});
			myLatlng = new google.maps.LatLng(json.latitude,json.longitude);	
			marker = new google.maps.Marker({
	            position: myLatlng,
                map: map,
                url: "/home/subprefecture/"+json.id,
                icon: "/static/images/icone_mapa.png"
    	    });

	    	map.setCenter(myLatlng);
	    	map.setZoom(12);	

      });	
	}


	function markgoaldetail( goal_id ){
		var ib;
		var markers = [];
		$.getJSON('/home/project_map_list', { id : goal_id } ,function(data,status){
			$.each(data.project, function(i, pj){
				marker = "";
				var myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);
				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
					url : "/home/project/"+pj.id,
	                icon: "/static/images/icone_mapa.png"
        	    });
				if ( pj.latitude != 0 && pj.longitude != 0){
					markers.push(marker);
				}
				var url = marker.url;
				var content = '<div class="project-bubble"><div class="name">';
				content += '<a href="' + url + '">';
				content += pj.name + '</a></div>';
				content += '</div>';
				google.maps.event.addListener(marker, 'mouseover', function() {
					if (!ib){
						ib = new InfoBubble({
				          map: map,
				          content: content,
				          shadowStyle: 0,
				          padding: 0,
				          backgroundColor: 'rgb(140,198,63)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#8cc63f',
				          disableAutoPan: true,
				          hideCloseButton: false,
				          arrowPosition: 50,
				          arrowStyle: 0,
				          MaxWidth: 340,
				          MinHeight: 60
				        });
				        ib.open(map, this);
					}else{
						ib.setContent(content);
						//ib.setPosition(myLatlng);
						ib.open(map, this);
					}
	        		//window.location.href = url;
	    		});
			});

			if (markers.length == 0){
				$('#map').hide();
			}

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
	function render_goal(){
		var ib;
		var myLatlng;
		$.post( "/home/goal/search_by_types", { type_id: $('#type_goal option:selected').val(), region_id: $('#goalregion option:selected').val() }, function( data ) {
			data.plural = (data.goals.length > 1);
			var template = $('#row_template').html();
			var html = Mustache.to_html(template, data);
			$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
			$('#result').html(html);
		},"json");
	}
	function render_goal_latlng(){
		var myLatlng;
		var ib;

		geocoder = new google.maps.Geocoder();

		geocoder.geocode({ 'address': $('#txtaddress').val() + ', Brasil', 'region': 'BR' }, function (results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				if (results[0]) {
					var latitude = results[0].geometry.location.lat();
					var longitude = results[0].geometry.location.lng();
					$('#txtEndereco').val(results[0].formatted_address);
					$.post("/home/goal/search_by_types",{ latitude: latitude, longitude: longitude, type_id: $('#type option:selected').val() },function(data){
						var template = $('#row_template').html();
	   					var html = Mustache.to_html(template, data);
		   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
						$('#result').html(html);
					},"json");
				}
			}
		});
	}

	function render_projects(){
	var ib;
	var myLatlng;
	$.post( "/home/project/search_by_types", { type_id: $('#type option:selected').val(), region_id: $('#homeregion option:selected').val() }, function( data ) {
					data.plural = (data.projects.length > 1);
					var template = $('#row_template').html();
	   				var html = Mustache.to_html(template, data);
	   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
					$('#result').html(html);
					$maps.deleteMarkers();
					$.each(data.projects, function(i, pj){
				
						if (pj.latitude == 0 && pj.longitude == 0) return;
						marker = "";	
						myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
						marker = new google.maps.Marker({
	    	            	position: myLatlng,
			                map: map,
		    	            url: "/home/project/"+pj.id,
		       		        icon: "/static/images/icone_mapa.png"
        	   		 	});
						marker_array.push(marker);
						var url = marker.url;
						var content = '<div class="project-bubble"><div class="name">';
						content += '<a href="' + url + '">';
						content += pj.name + '</a></div>';
						content += '</div>';
						google.maps.event.addListener(marker, 'mouseover', function() {
							if (!ib){
			  	              ib = new InfoBubble({
						          map: map,
						          content: content,
					              shadowStyle: 0,
						          padding: 0,
						          backgroundColor: 'rgb(140,198,63)',
						          borderRadius: 0,
						          arrowSize: 15,
						          borderWidth: 0,
						          borderColor: '#8cc63f',
						          disableAutoPan: true,
						          hideCloseButton: false,
						          arrowPosition: 50,
				   	      	      arrowStyle: 0,
				   			      MaxWidth: 340,
				   	      		  MinHeight: 60
				   	    	  });
				       		  ib.open(map, this);
							}else{
								ib.setContent(content);
								//ib.setPosition(myLatlng);
								ib.open(map, this);
							}
        			//window.location.href = url;
					})
				  })
					mc = new MarkerClusterer(map, marker_array);
					map.setCenter(myLatlng);
	    		},"json");


	}
	function render_project_latlng(){
		var myLatlng;
		var ib;
		geocoder.geocode({ 'address': $('#txtaddress').val() + ', Brasil', 'region': 'BR' }, function (results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				if (results[0]) {
					var latitude = results[0].geometry.location.lat();
					var longitude = results[0].geometry.location.lng();
					$('#txtEndereco').val(results[0].formatted_address);
					$.post("/home/project/search_by_types",{ latitude: latitude, longitude: longitude, type_id: $('#type option:selected').val() },function(data){
						var template = $('#row_template').html();
	   					var html = Mustache.to_html(template, data);
		   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
						$('#result').html(html);
						$.each(data.projects, function(i, pj){
							marker = "";	
							myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
							marker = new google.maps.Marker({
	    	    	        	position: myLatlng,
			        	        map: map,
		    	        	    url: "/home/project/"+pj.id,
			       		        icon: "/static/images/icone_mapa.png"
    	    	   		 	});
							var url = marker.url;
							var content = '<div class="project-bubble"><div class="name">';
							content += '<a href="' + url + '">';
							content += pj.name + '</a></div>';
							content += '</div>';
							google.maps.event.addListener(marker, 'mouseover', function() {
								if (!ib){
			  		              ib = new InfoBubble({
							          map: map,
							          content: content,
					        	      shadowStyle: 0,
						        	  padding: 0,
							          backgroundColor: 'rgb(140,198,63)',
							          borderRadius: 0,
							          arrowSize: 15,
							          borderWidth: 0,
							          borderColor: '#8cc63f',
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
        				//window.location.href = url;
						})
					  })
					map.setCenter(myLatlng);
					},"json");
					var location = new google.maps.LatLng(latitude, longitude);
					setlocal(location);
				}
			}
		});
	}
	return {
		initialize	             : initialize,
		loadproject              : loadproject,
		codeAddress              : codeAddress,
		setlocal                 : setlocal,
		markprojectdetail        : markprojectdetail,
		markgoaldetail     	     : markgoaldetail,
		markregiondetail         : markregiondetail,
	   	markorgdetail            : markorgdetail,
		marksubprefdetail        : marksubprefdetail,
		showregions              : showregions,
		deleteMarkers 			 : deleteMarkers,
		render_projects			 : render_projects,
		render_project_latlng	 : render_project_latlng,
		render_goal	 			 : render_goal,
		render_goal_latlng	 	 : render_goal_latlng
	};
}();

$(document).ready(function () {
	if ($("#pagetype").val() != 'homegoal'){	
		$maps.initialize();
	}
	if ($("#pagetype").val() == 'home'){	
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
	if ($("#pagetype").val() == 'homeregion'){
		$maps.showregions();
	}		
	if ($("#pagetype").val() == 'subprefdetail'){
		$maps.marksubprefdetail($("#subprefid").val());
	}		
	if ($("#pagetype").val() == 'orgdetail'){
		$maps.markorgdetail($("#orgid").val());
	}


//	$("#type_goal").change(function(){
//		var id = $( "#type_goal option:selected" ).val();
//		$("section.map .map-overlay").fadeIn();
//    	$.get("/home/goal/type",{type_id: id}).done( function(data){
//			$("section.map .map-overlay").fadeOut();
//			document.getElementById("result").innerHTML=data
//      	});
//	});

//	$("#goalregion").change(function(){
//		var id = $( "#goalregion option:selected" ).val();
//    	$.get("/home/goal/region",{region_id: id}).done( function(data){
//			document.getElementById("result").innerHTML=data
//      	});
//	});
	$('#search').on('click', function () {
		var ib;
		var id = $(this).data("id");
		if ($('#txtaddress').val() && $('type option:selected').val() != 'Distrito'){
				$maps.render_project_latlng()	
			} else {
				$maps.render_projects()
			}

	})
	$('#searchgoal').on('click', function () {
		var ib;
		var id = $(this).data("id");
		if ($('#txtaddress').val() && $('type option:selected').val() != 'Distrito'){
				$maps.render_goal_latlng()	
			} else {
				$maps.render_goal()
			}

	})

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
			$("section.map .map-overlay").fadeIn();
 			$.get("/home/project/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				$("section.map .map-overlay").fadeOut();
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
				document.getElementById("result").innerHTML=data
        	});
        	$maps.setlocal(location);
		}
		if ($("#pagetype").val() == 'projectdetail'){		
 			$.get("/home/project/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
				document.getElementById("result").innerHTML=data
        	});
		}
		
		if ($("#pagetype").val() == 'homegoal'){		
 			$.get("/home/goal/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
				document.getElementById("result").innerHTML=data
        	});
		}

		if ($("#pagetype").val() == 'goaldetail'){		
 			$.get("/home/goal/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
				document.getElementById("result").innerHTML=data
        	});
		}

		if ($("#pagetype").val() == 'homeregion'){		
			$.getJSON('/home/region/id',{latitude: ui.item.latitude, longitude: ui.item.longitude},function(data,status){
				if (data.message){
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
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
			
       	$(".metas-filtro .form .region .select-stylized").addClass("disabled");
		$("select#homeregion")[0].selectedIndex = 0;
       	$(".metas-filtro .form .cep button").removeClass("disabled");
    }
    });


});
