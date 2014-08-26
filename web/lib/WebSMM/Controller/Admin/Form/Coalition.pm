package WebSMM::Controller::Admin::Form::Coalition;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
}

sub process : Chained('base') : PathPart('coalition') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    
    $api->stash_result(
		$c, 'election_campaigns',
		params => {
			state_id 				=> $c->req->params->{state_id} ? $c->req->params->{state_id} : undef,
			city_id 				=> $c->req->params->{city_id} ? $c->req->params->{city_id} : undef,
			year					=> $c->req->params->{year},
			political_position_id 	=> $c->req->params->{political_position_id},
			filter_simple			=> 1,
			filter					=> 1,
		}
    );
    
#      my $e = $c->stash->{election_campaigns};
#      use DDP; p $e; exit;
    
    my $election_campaign_id;
    
    if( ! scalar @{ $c->stash->{election_campaigns} } ) {
		$c->req->params->{is_active} = 1;
		$api->stash_result(
			$c, 'election_campaigns',
			method => 'POST',
			body   => $c->req->params
		);
		
		if ( $c->stash->{error} ) {
			$c->detach( '/form/redirect_error', [] );
        }
        
        $election_campaign_id = $c->stash->{id};
    } else {
		$election_campaign_id = $c->stash->{election_campaigns}[0]{id};
    }
    
    $api->stash_result(
		$c, 'coalitions',
		method => 'POST',
		body   => {
			name 					=> $c->req->params->{name},
			election_campaign_id 	=> $election_campaign_id,
			is_active				=> 1
		}
    );
    
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    } else {
		$c->detach( '/form/redirect_ok2', [ '/admin/coalition/vinculate_parties', [ $c->stash->{id} ], {}, 'Cadastrado com sucesso!' ] );
	}
    
}

sub process_edit : Chained('base') : PathPart('coalition') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api 	= $c->model('API');
    my $params 	= { %{ $c->req->params } };
   
    $api->stash_result(
        $c, [ 'coalitions', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    } else {
        $c->detach( '/form/redirect_ok', [ '/admin/coalition/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_coalition') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( 
		$c, [ 'coalitions', $id ],
		method => 'PUT',
		body	=> {
			is_active => 0
		},
	);

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/coalition/index', {}, 'Removido com sucesso!' ] );
    }
}

sub add_parties : Chained('base') : PathPart('add_parties') : Args(1) {
	my ( $self, $c, $coalition_id ) = @_;
	
	my $api = $c->model('API');
	
	my $parties = $c->req->params;
	
	my @data;
	if(ref $c->req->params->{parties} eq 'ARRAY' ) {
		foreach my $party ( @{ $c->req->params->{parties} } ) {
			push( @data, { political_party_id => $party, coalition_id => $coalition_id} );
		}
	} else {
		push( @data, { political_party_id => $c->req->params->{parties}, coalition_id => $coalition_id} );
	}
	
	$api->stash_result(
		$c, 'coalitions/add_parties',
		params => {
			data => encode_json(\@data)
		}
	);
	
	if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
		$c->detach( '/form/redirect_ok2', [ '/admin/coalition/vinculate_parties', [ $coalition_id ], {}, 'Adicionado com sucesso!' ] );
    }
	
}

sub remove_parties : Chained('base') : PathPart('remove_party_relation') : Args(2) {
	my ( $self, $c, $coalition_id, $party_id ) = @_;
	
	my $api = $c->model('API');
	
	$api->stash_result(
		$c, ['coalitions/remove_party_relation', $coalition_id],
		params => {
			party_id => $party_id
		}
	);
	
	if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
		$c->detach( '/form/redirect_ok2', [ '/admin/coalition/vinculate_parties', [ $coalition_id ], {}, 'Removido com sucesso!' ] );
    }
}

__PACKAGE__->meta->make_immutable;

1;