var $admin = function () {
	
	function getCandidates(party_id) {
		$.ajax({
			url: '/admin/election_campaign/filter_candidate/'+party_id,
			dataType: 'html',
			success: function (result) {
				if( result ) {
					$('#candidates').html(result);
				} else {
					$('#candidates').html('');
					alert('Nenhum candidato cadastrado');
				}
			},
			error: function (err) {
				console.log(err);
			},
		});
	}

	function getElectionCampaigns(position_id) {
		$.ajax({
			url: '/admin/coalition/filter_election_campaign',
			dataType: 'html',
			data: { political_position_id: position_id },
			success: function (result) {
				console.log(result)
				if( result ) {
					$('#coalition').html(result);
				} else {
					$('#coalition').html('');
					alert('Nenhuma campanha eleitoral cadastrada');
				}
			},
			error: function (err) {
				console.log(err);
			},
			complete: function() {
				if($('#elm_state_id').length) {
					$('#elm_state_id').on('change', function () {
						$address.get_cities($(this).val());
					});
				}
			}
		});
	}
	
	function filterCandidates(param) {
		$.ajax({
			url: "/filter_candidates_by_ec",
			data:{election_campaign_id: param},
			dataType: 'html',
			success: function (result) {
				$("#elm_candidate_id").html(result);
			},
			error: function (err) {
				console.log(err);
			},
			complete: function() {
				$('#elm_candidate_id').removeAttr('disabled');
			}
		});
	}

	return {
		getCandidates: getCandidates,
		getElectionCampaigns: getElectionCampaigns,
		filterCandidates: filterCandidates
    };
}();

$(document).ready(function () {
	
	$('.disabled').attr('disabled', 'disabled');
	
	if( $('#candidates').length ) {
		$('#elm_political_party').change(function(){
			$admin.getCandidates($(this).val());
		});
	}
	
	if( $('#elm_political_position_id').length ) {
		$('#elm_political_position_id').change(function() {
			$admin.getElectionCampaigns($(this).val());
		});
	}
	
	$("[data-confirm]").click(function (event) {
		var confirmPrompt = event.currentTarget.attributes['data-confirm'].value;
		if (window.confirm(confirmPrompt)) {
			return 1;
		} else {
			event.preventDefault();
		}
		
		return 0;
	});
	
	var $election_campaign = $('#elm_election_campaign_id');
	if( $election_campaign.length ) {
		$election_campaign.change(function(){
			if($(this).val()) {
				$admin.filterCandidates($(this).val());
			}
		});
	}

});