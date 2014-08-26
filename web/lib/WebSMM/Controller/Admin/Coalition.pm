package WebSMM::Controller::Admin::Coalition;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('coalition') : CaptureArgs(0) {
	my ( $self, $c ) = @_;

	my $api = $c->model('API');
	
	my $org = $c->stash->{organizations};
	
	$api->stash_result(
		$c, 'political_positions',
		params =>{
			order => 'me.position'
		}
	);
	$c->stash->{select_political_positions} = [ map { [ $_->{id}, $_->{position} ] } @{ $c->stash->{political_positions} } ];
	
	$api->stash_result(
		$c, 'election_campaigns',
	);
	$c->stash->{select_election_campaigns} = [ map { [ $_->{id}, $_->{political_position}{position}, $_->{year} ] } @{ $c->stash->{election_campaigns} } ];

 	
 	$c->stash->{select_cities} = [0, 'Selecione'];
		
	if($org) {
		$api->stash_result(
			$c, 'states',
			params => {
				order   => 'me.name',
				id		=> $org ? $org->[0]{city}{state}{id} : undef
			}
		);
	} 
	else {
		$api->stash_result(
			$c, 'states',
			params => {
				order   => 'me.name',
			}
		);
	}
	$c->stash->{select_states} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];
	
	$api->stash_result(
		$c, 'political_parties',
		params => {
			order   => 'me.name',
		}
	);
	$c->stash->{select_parties} = [ map { [ $_->{id}, $_->{acronym} ] } @{ $c->stash->{political_parties} } ];
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
	my ( $self, $c, $id ) = @_;

	my $api = $c->model('API');

	$api->stash_result(
		$c, [ 'coalitions', $id ],
		stash => 'coalition_obj'
	);
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api     = $c->model('API');
    my $form    = $c->model('Form');
    
    my $item_per_page 	= 10;
	my $page 			= $c->req->params->{page} || 1;
	
	$api->stash_result(
		$c, 'coalitions',
		params => {
			order		=> 'political_position.position',
			page		=> $page,
			pagination 	=> 1,
			is_active	=> 1,
			organization_state_id => $c->stash->{organizations}->[0]{city}{state}{id} ? 
				$c->stash->{organizations}->[0]{city}{state}{id} : undef
		}
	);
	    
    $c->stash->{count_partial} 	= scalar keys $c->stash->{coalitions};
	$c->stash->{total}   		= $c->stash->{count};
	$c->stash->{results} 		= $c->stash->{coalitions};

	$c->stash(
		current_page  => $page,
		item_per_page => $item_per_page
	);

	$c->stash->{pag_req}     = $c->req;
	$c->stash->{total_pages} = int( ceil( $c->stash->{total} / $c->stash->{item_per_page} ) );

	$c->stash->{previous_page} = ( $page > 1 )                         ? $page - 1 : '';
	$c->stash->{next_page}     = ( $page < $c->stash->{total_pages} )  ? $page + 1 : '';
	$c->stash->{first_page}    = ( $page == 1 )                        ? ''        : 1;
	$c->stash->{last_page}     = ( $page >= $c->stash->{total_pages} ) ? ''        : $c->stash->{total_pages};
}

sub add : Chained('base') : PathPart('new') : Args(0) {

}

sub edit : Chained('object') : PathPart('') : Args(0) {

}

sub filter_election_campaign : Chained('base') : PathPart('filter_election_campaign') : Args(0) {
	my ( $self, $c ) = @_;
	
	my $api = $c->model('API');
	
	my $title;
	foreach my $position ( @{ $c->stash->{select_political_positions} } ) {
		if( $position->[0] == $c->req->params->{political_position_id} ) {
			$title = $position->[1];
		}
	}
	
	if( $title eq 'Governador' ) {
		$c->stash->{select_cities} = undef;
	}
	elsif( $title eq 'Presidente' ) {
		$c->stash->{select_cities} = undef;
		$c->stash->{select_states} = undef;
	}
	
	$c->stash(
		template        => 'auto/election_campaign.tt',
		without_wrapper => 1,
	);
	
}

sub vinculate_parties : Chained('base') : PathPart('vinculate_parties') : Args(1) {
	my ( $self, $c, $coalition_id ) = @_;
	
	$c->stash->{coalition_id} = $coalition_id;
	
	my $api = $c->model('API');
	
	$api->stash_result(
		$c, ['coalitions/get_parties', $coalition_id],
		params => {
			order => 'me.name',
		}
	);
	
	$api->stash_result(
		$c, 'political_parties',
		stash => 'avlb_parties',
		params => {
			order 	=> 'me.name',
			status 	=> 1
		}
	);

}

__PACKAGE__->meta->make_immutable;

1;