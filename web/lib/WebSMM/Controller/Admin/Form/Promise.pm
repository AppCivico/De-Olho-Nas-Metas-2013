package WebSMM::Controller::Admin::Form::Promise;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub process : Chained('base') : PathPart('promise') : Args(0) {
    my ( $self, $c ) = @_;

    my $api     = $c->model('API');
    my $form    = $c->model('Form');
    
    my $params 	= { %{ $c->req->params } };
    
    $form->format_date($params, 'publication_date');
    
    $api->stash_result(
		$c, [ 'election_campaigns', $c->req->params->{election_campaign_id} ],
		stash => 'election_campaign_obj'
    );

    if(
		$c->stash->{election_campaign_obj}{political_position}{id} == 1 
		&& $c->stash->{election_campaign_obj}{political_position}{position} eq 'Presidente'
	) {
		$params->{country_id} = 1;
	} 
	elsif( $c->stash->{election_campaign_obj}{political_position}{position} eq 'Governador' ) {
		$params->{state_id} = $c->stash->{election_campaign_obj}{state}{id};
	} 
	elsif( $c->stash->{election_campaign_obj}{political_position}{position} eq 'Prefeito' ) {
		$params->{state_id}	= $c->stash->{election_campaign_obj}{state}{id};
		$params->{city_id} 	= $c->stash->{election_campaign_obj}{city}{id};
	}

    $api->stash_result(
		$c, ['promises'],
		method => 'POST',
		body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    } else {
		
			my $upload = $c->req->upload('promise_file');
		
		if( $upload ) {
			my $data = {
				upload 	=> $upload,
				params	=> $c->req->params
			};
				
			$self->upload_file($c, \%$data);
		}
    
		$c->detach( '/form/redirect_ok', [ '/admin/promise/index', {}, 'Cadastrado com sucesso!' ] );
	}
    
}

sub process_edit : Chained('base') : PathPart('promise') : Args(1) {
	my ( $self, $c, $id ) = @_;

    my $api 	= $c->model('API');
    my $form    = $c->model('Form');
    
    my $params 	= { %{ $c->req->params } };
    
    $form->format_date($params, 'publication_date');
    
    $api->stash_result(
		$c, [ 'election_campaigns', $c->req->params->{election_campaign_id} ],
		stash => 'election_campaign_obj'
    );

    if(
		$c->stash->{election_campaign_obj}{political_position}{id} == 1 
		&& $c->stash->{election_campaign_obj}{political_position}{position} eq 'Presidente'
	) {
		$params->{country_id} = 1;
	} 
	elsif( $c->stash->{election_campaign_obj}{political_position}{position} eq 'Governador' ) {
		$params->{state_id} = $c->stash->{election_campaign_obj}{state}{id};
	} 
	elsif( $c->stash->{election_campaign_obj}{political_position}{position} eq 'Prefeito' ) {
		$params->{state_id}	= $c->stash->{election_campaign_obj}{state}{id};
		$params->{city_id} 	= $c->stash->{election_campaign_obj}{city}{id};
	}
   
    $api->stash_result(
        $c, [ 'promises', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    } else {
    
		my $upload = $c->req->upload('promise_file');
		
		if( $upload ) {
			my $data = {
				upload 	=> $upload,
				params	=> $c->req->params
			};
				
			$self->upload_file($c, \%$data);
		}
		
        $c->detach( '/form/redirect_ok', [ '/admin/promise/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_promise') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'promises', $id ], method => 'DELETE' );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/promise/index', {}, 'Removido com sucesso!' ] );
    }
}

sub upload_file : Private {
	my ($self, $c, $data) = @_;
	
	my $api = $c->model('API');
	
 	my $upload = $data->{upload};

 	$api->stash_result(
 		$c, 'candidates/upload_file',
 		method => 'UPLOAD',
 		body   => [
 			type			=> 'promise',
 			created_by		=> $c->user->id,
 			promise_id 		=> $c->stash->{id},
 			file_name		=> $upload->filename,
 			file 			=> [ $upload->tempname ],
 			name 			=> $data->{params}{name},
 			source			=> $data->{params}{source},
 			candidate_id	=> $data->{params}{candidate_id},
 			source_type_id	=> $data->{params}{source_type_id},
 		]
 	);
 
 	if ( $c->stash->{error} ) {
 		$c->detach( '/form/redirect_error', [ '/admin/promise/index', {}, 'Problemas ao cadastrar arquivo para a promessa.' ] );
 	} else {
 		$c->detach( '/form/redirect_ok', [ '/admin/promise/index', {}, 'Alterado com sucesso!' ] );
 	}

}

__PACKAGE__->meta->make_immutable;

1;
