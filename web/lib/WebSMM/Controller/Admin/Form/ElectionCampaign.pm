package WebSMM::Controller::Admin::Form::ElectionCampaign;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
}

sub process : Chained('base') : PathPart('election_campaign') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    
    $api->stash_result(
		$c, 'election_campaigns',
		method => 'POST',
		body   => $c->req->params
    );
    
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    } else {
		$c->detach( '/form/redirect_ok2', [ '/admin/electioncampaign/vinculate_candidate', [ $c->stash->{id} ], {}, 'Cadastrado com sucesso!' ] );
	}
    
}

sub process_edit : Chained('base') : PathPart('election_campaign') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api 	= $c->model('API');
    my $params 	= { %{ $c->req->params } };
   
    $api->stash_result(
        $c, [ 'election_campaigns', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    } else {
        $c->detach( '/form/redirect_ok', [ '/admin/electioncampaign/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_election_campaign') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( 
		$c, [ 'election_campaigns', $id ],
		method 	=> 'PUT',
		body	=> {
			is_active => 0
		},
	);

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/electioncampaign/index', {}, 'Removido com sucesso!' ] );
    }
}

sub add_candidates : Chained('base') : PathPart('add_candidates') : Args(1) {
	my ( $self, $c, $election_campaign_id ) = @_;
	
	my $api = $c->model('API');
	
	my $can = $c->req->params;
	
	my @data;
	if(ref $c->req->params->{candidate} eq 'ARRAY' ) {
		foreach my $can ( @{ $c->req->params->{candidate} } ) {
			push( @data, { candidate_id => $can, election_campaign_id => $election_campaign_id} );
		}
	} else {
		push( @data, { candidate_id => $c->req->params->{candidate}, election_campaign_id => $election_campaign_id} );
	}
	
	$api->stash_result(
		$c, 'election_campaigns/add_candidates',
		params => {
			data => encode_json(\@data)
		}
	);
	
	if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
		$c->detach( '/form/redirect_ok2', [ '/admin/electioncampaign/vinculate_candidate', [ $election_campaign_id ], {}, 'Adicionado com sucesso!' ] );
    }
	
}

sub remove_candidates : Chained('base') : PathPart('remove_candidate_relation') : Args(2) {
	my ( $self, $c, $election_campaign_id, $candidate_id ) = @_;
	
	my $api = $c->model('API');
	
	$api->stash_result(
		$c, ['election_campaigns/remove_candidate_relation', $election_campaign_id],
		params => {
			candidate_id => $candidate_id
		}
	);
	
	if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
		$c->detach( '/form/redirect_ok2', [ '/admin/electioncampaign/vinculate_candidate', [ $election_campaign_id ], {}, 'Removido com sucesso!' ] );
    }
}

sub add_runoff : Chained('base') : PathPart('add_runoff') : Args(1) {
	my ( $self, $c, $election_campaign_id ) = @_;
	
	my $api = $c->model('API');
	
	my $can = $c->req->params;
	
	my @data;
	if(ref $c->req->params->{candidate} eq 'ARRAY' ) {
		foreach my $can ( @{ $c->req->params->{candidate} } ) {
			push( @data, { candidate_id => $can, election_campaign_id => $election_campaign_id} );
		}
	} else {
		push( @data, { candidate_id => $c->req->params->{candidate}, election_campaign_id => $election_campaign_id} );
	}
	
	$api->stash_result(
		$c, 'election_campaigns/add_runoff',
		params => {
			data => encode_json(\@data)
		}
	);
	
	if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
		$c->detach( '/form/redirect_ok2', [ '/admin/electioncampaign/runoff', [ $election_campaign_id ], {}, 'Adicionado com sucesso!' ] );
    }
	
}

sub remove_runoff : Chained('base') : PathPart('remove_candidate_runoff') : Args(2) {
	my ( $self, $c, $election_campaign_id, $candidate_id ) = @_;
	
	my $api = $c->model('API');
	
	$api->stash_result(
		$c, ['election_campaigns/remove_candidate_runoff', $election_campaign_id],
		params => {
			candidate_id => $candidate_id
		}
	);
	
	if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
		$c->detach( '/form/redirect_ok2', [ '/admin/electioncampaign/runoff', [ $election_campaign_id ], {}, 'Removido com sucesso!' ] );
    }
}

__PACKAGE__->meta->make_immutable;

1;