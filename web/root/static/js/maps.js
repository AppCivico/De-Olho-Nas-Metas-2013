var $maps = function () {
    var map;
    var addr;
    var geocoder;
    var markersArray = [];
    var points = [];
    var polyline;

    function initialize() {
        var latlng 			= new google.maps.LatLng(-23.5505233, -46.63429819999999); //praça da sé
        geocoder 			= new google.maps.Geocoder();
        directionsDisplay 	= new google.maps.DirectionsRenderer();

        var mapOptions = {
            zoom: 8,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

		if (!$('#elm_origin').length && !$('#vehicle_tracker_vehicle').length && !$('#form_tracker').length) {
            google.maps.event.addListener(map, 'click', function (event) {
                clearOverlays();
                addMarker(event.latLng);
                reverseCode(event.latLng);

                $("#elm_lat_lng").val(event.latLng.toString());
            });
        }
    }

    function codeAddress(address) {
        if (address.length != 0 && addr != address) {
            geocoder.geocode({
                'address': address
            }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    clearOverlays();
                    console.log(results);
                } else {
                    alert('Falha ao localizar endereço');
                }
            });
        }

        addr = address;
    }

    function reverseCode(latlng) {
        geocoder.geocode({
            'latLng': latlng
        }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[1]) {
                    /*todo: tornar generico */
                    console.log(results[1]);
                    $('#elm_parking_address').val(results[1].formatted_address);
                } else {
                    alert('Endereço não encontrado.');
                }
            } else {
                alert('Falha na busca por endereços.');
            }
        });
    }

    function addMarker(location, customMap) {
		
		if(customMap) {
			map = customMap;
		}
		
        marker = new google.maps.Marker({
            position: location,
            map: map
        });

        markersArray.push(marker);
    }

    function clearOverlays() {
        if (markersArray) {
            for (i in markersArray) {
                markersArray[i].setMap(null);
            }
            deleteOverlays();
        }
    }

    function deleteOverlays() {
        if (markersArray) {
            for (i in markersArray) {
                markersArray[i].setMap(null);
            }
            markersArray.length = 0;
        }
    }

    function calcRoute(positions) {
        if (positions.length > 0) {
            var keep = {};
            var points = [];

            for (var i = 0; i < positions.length; i++) {
                keep["z" + i] = new google.maps.DirectionsService();

                if (positions[i].origin && positions[i].destination) {
                    var request = {
                        origin: positions[i].origin,
                        destination: positions[i].destination,
                        travelMode: google.maps.TravelMode.DRIVING
                    };

                    keep["z" + i].route(request, function (result, status) {
                        keep["x" + i] = new google.maps.DirectionsRenderer({
                            suppressMarkers: true,
                            suppressInfoWindows: true
                        });

                        if (status == google.maps.DirectionsStatus.OK) {
                            points.push(result.routes[0].overview_path[0]);
                            save_positions(points);
                            keep["x" + i].setDirections(result);
                            keep["x" + i].setMap(map);
                        }
                    });
                }
            }

        }
    }

    function buildHeatMap(positions) {
        var taxiData = [];

        for (i = 0; i < positions.length; i++) {
            taxiData.push(new google.maps.LatLng(positions[i].lat, positions[i].lng));
        }

        var pointArray = new google.maps.MVCArray(taxiData);

        heatmap = new google.maps.visualization.HeatmapLayer({
            data: pointArray
        });

        heatmap.setMap(map);
    }

    function save_positions(positions) {
        console.log(positions);
    }

    function printPolyline(positions) {
		clearPolyline();
		clearOverlays();
		
        if (!positions) {
            return false;
        }

        var path         = [];
        path.length      = 0;
        var latLngBounds = new google.maps.LatLngBounds();


        for (var i = 0; i < positions.length; i++) {

            path.push(new google.maps.LatLng(positions[i].lat, positions[i].lng));

            latLngBounds.extend(path[i]);

            var $date;
            var $hour;

            if (positions[i].track_event.length) {
                $date = positions[i].track_event.split(' ');
                $hour = $date[1].substr(0, 5);
                $date = $date[0].substr(8, 2) + '/' + $date[0].substr(5, 2) + '/' + $date[0].substr(0, 4);
            }
            
            if(i == 0 || i == positions.length -1) {
				var marker = new google.maps.Marker({
					map: map,
					position: path[i],
	                icon: '/static/img/1381172153_Map-Marker-Marker-Outside-Azure.png',
					info: 'Data: ' + $date + '<br /> Hora: ' + $hour + '<br />Velocidade :' + positions[i].speed + ' Km/h'
				});
				
			} else {
				var marker = new google.maps.Marker({
					map: map,
					position: path[i],
					icon: '/static/img/invisible.png',
					info: 'Data: ' + $date + '<br /> Hora: ' + $hour + '<br />Velocidade :' + positions[i].speed + ' Km/h'
				});
			}
			markersArray.push(marker);

            var infowindow = new google.maps.InfoWindow(),
            marker;

            google.maps.event.addListener(marker, 'mouseover', (function (marker, i) {
                return function () {
                    infowindow.setContent(this.info);
                    infowindow.open(map, marker);
                }
            })(marker));
        }

//         clearPolyline();

        polyline = new google.maps.Polyline({
            map: map,
            path: path,
            strokeColor: '#0000FF',
            strokeOpacity: 0.7,
            strokeWeight: 5
        });

        map.fitBounds(latLngBounds);
    }

    function clearPolyline() {
        if (polyline) {
            polyline.setMap(null);
        }
    }

    function getPoints(form_data) {
        $.ajax({
            url: "/tracker-manager/get_positions",
            data: form_data,
            dataType: 'json',
            success: function (result) {
				if(result) {
					printPolyline(result);	
				} else {
					alert("Nenhuma posição encontrada");
					clearPolyline();
					clearOverlays();
				}
				
            },
            error: function (err) {
                console.log(err);
            },
            complete: function () {
                $('#search_track').button('reset');
            }
        });
    }

    function drawingManager() {
        var polyOptions = {
            fillColor: "#00BFFF",
            strokeWeight: 0,
            fillOpacity: 0.45,
            editable: true
        };

        var drawingManager = new google.maps.drawing.DrawingManager({
            drawingMode: google.maps.drawing.OverlayType.POLYGON,
            drawingControl: true,
            polygonOptions: polyOptions,
            drawingControlOptions: {
                position: google.maps.ControlPosition.TOP_CENTER,
                drawingModes: [google.maps.drawing.OverlayType.POLYGON]
            }
        });

        google.maps.event.addListener(drawingManager, 'polygoncomplete', function (polygon) {
            var path    = polygon.getPath();
            var aux     = [];

            for (i = 0; i < path.getLength(); i++) {
                aux.push(path.getAt(i).lat().toString() + " " + path.getAt(i).lng().toString());

//              Repetindo o primeiro ponto para fechar o polígono
                if (i == path.getLength() - 1) {
                    aux.push(path.getAt(i).lat().toString() + " " + path.getAt(i).lng().toString());
                }
            }

            points.push(aux);
			
			if( $('#report_driver').length ) {
				buildDriversReportPoints(points);
			}
        });

        drawingManager.setMap(map);
    }

    function searchAssociateds(campaign_id) {
        if (points.length <= 0) {
            setTimeout(function () {
                $("#search_points").button('reset');
            })

            alert('Nenhum critério de pesquisa');

            return false;
        }

        var $distance = $('#elm_distance').val();
        if($distance && $distance < 500) {
            $('#distance_error').show();

            setTimeout(function () {
                $("#search_points").button('reset');
            })

            return false;
        }

        var z;
        if (campaign_id) {
            $z = $('<input type="hidden" name="points"/><input type="hidden" name="campaign_id" value=' + campaign_id + '/>');
        } else {
            $z = $('<input type="hidden" name="points"/>');
        }
        $z.val($.toJSON(points));

        $('#route_filter').append($z);

        var $form = $('#route_filter').serialize();
        $z.remove();

        $.ajax({
            url: '/admin/associated_routes/search',
            data: $form,
            contentType: "application/json; charset=utf-8",
            dataType: 'html',
            success: function (result) {
                $('#search_box').html(result);
                $('#search_box').show(result);
            },
            error: function (err) {
                console.log(err);
            },
            complete: function () {
                $("#search_points").button('reset');

                if ($('#campaign_id').val()) {
                    $('#result_form').append('<input type=hidden name=campaign_id value=' + $('#campaign_id').val() + '></input>');
                }

                $('#distance_error').hide();
            }
        });
    }
    
    function buildDriversReportPoints($points) {
		if ($points.length <= 0) {
			setTimeout(function () {
				$("#search_points").button('reset');
			})
			
			alert('Nenhum critério de pesquisa');
			
			return false;
		}
		var $z = $('<input type="hidden" name="points" value='+$points+'/>');
		$z.val($points);
		
		$('#report_driver').append($z);
	}
	
	function real_time_position(lat, lng) {
		var myLatlng = new google.maps.LatLng(lat,lng);
		clearOverlays();
		
		options = {
			zoom: 15,
			center: myLatlng
		}
		customMap = new google.maps.Map(document.getElementById('map_canvas'), options);
		
		addMarker(myLatlng, customMap);
	}

    return {
        initialize: initialize,
        codeAddress: codeAddress,
        calcRoute: calcRoute,
        reverseCode: reverseCode,
        getPoints: getPoints,
        buildHeatMap: buildHeatMap,
        drawingManager: drawingManager,
        searchAssociateds: searchAssociateds,
		real_time_position: real_time_position
    };

}();

$(document).ready(function () {
    $maps.initialize();

    if ($('#elm_address').length > 0 && $('#elm_address').val().length > 0) {
        $maps.codeAddress('#elm_lat_lng', '#elm_address');
    }

    if ($('#elm_parking_address').length) {

        if ($('#elm_parking_address').val().length > 0) {
            $maps.codeAddress('#elm_lat_lng', '#elm_parking_address');
        }

        $('#elm_parking_address').on('blur', function () {
            $maps.codeAddress('#elm_lat_lng', $(this));
        });

    }
    
    $('#elm_address').blur(function () {
        $maps.codeAddress('#elm_lat_lng', '#elm_address');
    });

    if (
        $('#elm_origin').length && $('#elm_origin').val().length &&
        $('#elm_destination').length && $('#elm_destination').val().length
    ) {
        $maps.codeAddress('#elm_origin_lat_lng', '#elm_origin');
        $maps.codeAddress('#elm_destination_lat_lng', '#elm_destination');
        $maps.calcRoute();
    }

    $('#elm_origin, #elm_destination').blur(function () {
        if ($('#elm_origin').val().length > 0 && $('#elm_destination').val().length > 0) {
            $maps.codeAddress('#elm_origin_lat_lng', '#elm_origin');
            $maps.codeAddress('#elm_destination_lat_lng', '#elm_destination');
            $maps.calcRoute();
        }
    });

    if ($('#form_tracker').length) {
	
		$('#form_tracker').on('submit', function () {
			
			if(! $('#elm_tracker_id').val() || ! $('#elm_date').val()) {
				alert('Preencha os campos corretamente');
				$('#search_track').button('reset');
				return false;
			}
			
			$maps.getPoints($(this).serialize());
			
			event.preventDefault();
		});
		
    }

    if ( ('#route_filter').length && !$('#form_tracker').length && !$('#real_time_map').length ) {
         $maps.drawingManager();
    }

});