var $admin = function () {

    function getCostumers(form) {
        var $data;

        if (form) {
            $data = form;
        }

        $.ajax({
            url: "/admin/campaign/search_customer",
            dataType: 'html',
            data: $data,
            success: function (result) {
                $('#modal_body').html(result);
            },
            error: function (err) {
                console.log(err);
            },
            complete: function () {
                $('.customer_choice').click(function () {
                    $('#elm_customer').val($(this).val());
                    $('#customer_name').text(($(this).parent().text()));
                });
            }
        });
    }

    function analiseDriverDocuments(document_id, element) {
        var $url;
        if (element == 'accept') {
            $url = '/admin/validate-driver-documents/validate/' + document_id;
        } else {
            $url = '/admin/validate-driver-documents/reject/' + document_id;
        }

        $.ajax({
            url: $url,
            dataType: 'json',
            success: function (result) {
                $('#status_' + document_id).text(result.status);
                alert('Documento ' + result.status);
            },
            error: function (err) {
                console.log(err);
            }
        });

    }

    function sendInvitation() {
        var $campaign_id = $('#campaign_id').val();
        var $vehicle_id = $('#vehicle_id').val();

        $.ajax({
            url: '/admin/form/send_invitation',
            data: {
                campaign_id: $campaign_id,
                vehicle_id: $vehicle_id
            },
            dataType: 'json',
            success: function (result) {
                $('#sent_txt').html('<dt>Convite enviado</dt>');
            },
            error: function (err) {
                console.log(err);
            }
        });

    }

    function getAssociatedLatLnt() {
        $.ajax({
            url: '/admin/associated_routes/get_positions',
            dataType: 'json',
            success: function (result) {
                $maps.buildHeatMap(result);
            },
            error: function (err) {
                console.log(err);
            }
        });
    }
    
    function getRealTimePosition() {
		
		var $control;
		
		$.ajax({
			url: '/user/vehicle_tracker/get_real_time_position',
			dataType: 'json',
			success: function (result) {
				if(result.lat && result.lng) {
					$('#date_position').text(result.date);
					$('#speed').text(result.speed+' Km/h');
					$('#hour').text(result.hour);
					
					$maps.real_time_position(result.lat, result.lng);
					$control = 0;
				} else {
					alert('Não foram encontradas posições para esse veículo.');
					
					$control = 1;
				}
			},
			error: function (err) {
				console.log(err);
			},
			complete: function() {
				$("#upload_position_real").button('reset');
				if(!$control) {
					assignReload();
				}
			}
		});
		
		return $control;
	}
	
	function assignReload() {
		setInterval(function(){
			$admin.getRealTimePosition();
		},180000); //3 minutos
	}

    return {
        getCostumers: getCostumers,
        analiseDriverDocuments: analiseDriverDocuments,
        sendInvitation: sendInvitation,
        getAssociatedLatLnt: getAssociatedLatLnt,
		getRealTimePosition: getRealTimePosition
    };
}();

$(document).ready(function () {
    if ($('#customer_list').length) {
        $('#customer_list').click(function () {
            $admin.getCostumers();
        });
    }

    $('#search_customer').on('submit', function () {
        getCostumers($(this).serialize());
    });

    var $check_all = $('#check_all');
    if ($check_all.length) {
        $check_all.on('click', function () {
            if ($(this).attr('checked') == 'checked') {
                $(this).removeAttr('checked');
                $('.check_driver').attr('checked', false);
            } else {
                $(this).attr('checked', 'checked');
                $('.check_driver').attr('checked', true);
            }
        });
    }

    var $approve_docs = $('.approve_docs');
    if ($approve_docs.length) {
        $approve_docs.click(function () {
            var $info = $(this).attr('id').split('_');

            $admin.analiseDriverDocuments($info[1], $info[0]);
        });
    }

    var $send_invitation = $('#send_invitation');
    if ($send_invitation.length) {
        $send_invitation.click(function () {
            $admin.sendInvitation();
        });
    }

    var $cancel_campaign = $('#cancel_campaign');
    if ($cancel_campaign.length) {
        $cancel_campaign.click(function () {
            $('#campaign_status').val(7);
        });
    }

    $admin.getAssociatedLatLnt();

    var $search_points = $('#search_points');
    if ($search_points.length) {
        $search_points.click(function () {
            $maps.searchAssociateds();
        });
    }
    
    var $report_driver = $('#report_driver');
    if($report_driver.length) {
		$('#search_driver_report').click(function(){
			$report_driver.submit();
		});
    }
    
    var $real_time_map = $('#real_time_map');
	if($real_time_map.length) {
		$admin.getRealTimePosition();
		$('#upload_position_real').click(function(){
			$admin.getRealTimePosition();
		});
	}

});