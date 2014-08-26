package WebSMM::Controller::Admin::Form::Candidate;
use Moose;
use namespace::autoclean;
use DateTime;
use utf8;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub process : Chained('base') : PathPart('candidate') : Args(0) {
    my ( $self, $c ) = @_;
	
    my $api     = $c->model('API');
    my $form    = $c->model('Form');
    
    my $params 	= { %{ $c->req->params } };
    
    $form->only_number($params, 'phone');
    
    $api->stash_result(
		$c, ['candidates'],
		method => 'POST',
		body   => $params
    );
    
    if ( $c->stash->{error} ) {
    
        $c->detach( '/form/redirect_error', [] );
        
    } else {
    
		if( $c->req->upload ) {
			my $upload = $c->req->upload('img_profile');
			
			if($upload) {
				$api->stash_result(
					$c, 'candidates/upload_file',
					method => 'UPLOAD',
					body   => [
						candidate_id 	=> $c->stash->{id},
						file 			=> [ $upload->tempname ],
						type			=> 'profile'
					]
				);
			
				if ( $c->stash->{error} ) {
					$c->detach( '/form/redirect_error', [ '/admin/candidate/index', {}, 'Problemas ao associar imagem de perfil ao candidato.' ] );
				}
			}
			
			$upload = $c->req->upload('gvt_program');
			
			if($upload) {
				$api->stash_result(
					$c, 'candidates/upload_file',
					method => 'UPLOAD',
					body   => [
						candidate_id 	=> $c->stash->{id},
						file 			=> [ $upload->tempname ],
						type			=> 'program'
					]
				);
		
				if ( $c->stash->{error} ) {
					$c->detach( '/form/redirect_error', [ '/admin/candidate/index', {}, 'Problemas ao cadastrar programa de governo ao candidato.' ] );
				}
			}
		}
		
		$c->detach( '/form/redirect_ok', [ '/admin/candidate/index', {}, 'Cadastrado com sucesso!' ] );
	}
    
}

sub process_edit : Chained('base') : PathPart('candidate') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api 	= $c->model('API');
    my $params 	= { %{ $c->req->params } };
   
    $api->stash_result(
        $c, [ 'candidates', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
    
        $c->detach( '/form/redirect_error', [] );
        
    } else {
		if( $c->req->upload ) {
			my $upload = $c->req->upload('img_profile');
			
			if($upload) {
				$api->stash_result(
					$c, 'candidates/upload_file',
					method => 'UPLOAD',
					body   => [
						candidate_id 	=> $c->stash->{id},
						file 			=> [ $upload->tempname ],
						type			=> 'profile'
					]
				);
			
				if ( $c->stash->{error} ) {
					$c->detach( '/form/redirect_error', [ '/admin/candidate/index', {}, 'Problemas ao associar imagem de perfil ao candidato.' ] );
				}
			}
			
			$upload = $c->req->upload('gvt_program');
			
			if($upload) {
				$api->stash_result(
					$c, 'candidates/upload_file',
					method => 'UPLOAD',
					body   => [
						candidate_id 	=> $c->stash->{id},
						file 			=> [ $upload->tempname ],
						type			=> 'program'
					]
				);
		
				if ( $c->stash->{error} ) {
					$c->detach( '/form/redirect_error', [ '/admin/candidate/index', {}, 'Problemas ao cadastrar programa de governo ao candidato.' ] );
				}
			}
		}
    
        $c->detach( '/form/redirect_ok', [ '/admin/candidate/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_candidate') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( 
		$c, 'election_campaigns',
		params => {
			elected_candidate_id => $id
		}
    );
    
    if( @{ $c->stash->{election_campaigns} } ) {
		$c->stash->{error} = 'Esse candidato não pode ser removido';
		
		$c->detach( '/form/redirect_error', []);
    }
    
    $api->stash_result( $c, [ 'candidates', $id ], method => 'DELETE' );
    
    

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/candidate/index', {}, 'Removido com sucesso!' ] );
    }
}

__PACKAGE__->meta->make_immutable;

1;
