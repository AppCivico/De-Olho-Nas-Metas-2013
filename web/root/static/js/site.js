var $site = function(){
	function getCandidates(candidate_id) {
		
		if(candidate_id) {
			$.ajax({
				url: "/perfil-candidato/"+candidate_id,
				dataType: 'html',
				success: function (result) {
					$('.modal-body').html(result);
				},
				error: function (err) {
					console.log(err);
				},
				complete: function () {
					$('#modalCandidato').modal({show:true})
				}
			});
		}
	}
	
	function filterCandidates(param) {
		$.ajax({
			url: "/filter_promise_select",
			data:{filter: param},
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
	
	function filterCategory(param) {
		$.ajax({
			url: "/filter_category_select",
			data:{candidate_id: param},
			dataType: 'html',
			success: function (result) {
				$("#elm_category_id").html(result);
			},
			error: function (err) {
				console.log(err);
			},
		});
	}
	
	return {
		getCandidates: getCandidates,
		filterCandidates: filterCandidates,
		filterCategory: filterCategory
	}
	
}();

$(document).ready(function () {
	
	$('.disabled').attr('disabled', 'disabled');
	
	if( $('#elm_electoral_regional_court_select').length ) {
		
		$('#elm_electoral_regional_court_select').change(function(){
			if( $(this).val() ) {
				window.location.assign('/processos-tre/'+$(this).val());
			}
		});
		
	}
	
	if( $('#modalCandidato').length ) {
		$('.profile_candidate').click(function() {
			$site.getCandidates($(this).attr('id'));
		});
	}
	
	var $candidate 	= $('#elm_candidate_id');
	var $state		= $('#elm_state_id');
	var $category	= $('#elm_category_id');
	
	if( $candidate.length && $state.length && $category.length ) {
		$state.change(function(){
			if($(this).val()) {
				$site.filterCandidates($(this).val());
			}
		});
		
		$candidate.change(function(){
			$site.filterCategory($(this).val());
		});
	}
});