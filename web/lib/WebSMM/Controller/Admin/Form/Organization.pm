package WebSMM::Controller::Admin::Form::Organization;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub process : Chained('base') : PathPart('organization') : Args(0) {
    my ( $self, $c ) = @_;

    my $api     = $c->model('API');
    my $form	= $c->model('Form');
    
    my $params 	= { %{ $c->req->params } };
    
	$form->only_number($params, 'phone', 'postal_code');
    
    $api->stash_result(
		$c, ['organizations/complete'],
		method => 'POST',
		body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    } else {
		$c->detach( '/form/redirect_ok', [ '/admin/organization/index', {}, 'Cadastrado com sucesso!' ] );
	}
    
}

sub process_edit : Chained('base') : PathPart('organization') : Args(1) {
	my ( $self, $c, $id ) = @_;

    my $api 	= $c->model('API');
    my $form	= $c->model('Form');
   
    my $params 	= { %{ $c->req->params } };
    
    $form->only_number($params, 'phone', 'postal_code');
   
    $api->stash_result(
        $c, [ 'organizations', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    } else {
        $c->detach( '/form/redirect_ok', [ '/admin/organization/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_organization') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'organizations', $id ], method => 'DELETE' );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/federalelectoralprocess/index', {}, 'Removido com sucesso!' ] );
    }
}

sub process_password : Chained('base') :PathPart('change_organization_password') : Args(0) {
	my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    
    $c->req->params->{password_defined} = 1;
	
    $api->stash_result(
		$c, [ 'users', $c->user->id ],
		method 	=> 'PUT',
		body 	=> $c->req->params
	);
	
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
		$c->req->params->{email} = $c->user->email;
		
 		$c->authenticate( $c->req->params );
		
        $c->detach( '/form/redirect_ok', [ '/admin/dashboard/index', {}, 'Senha alterada com sucesso!' ] );
    }
}

__PACKAGE__->meta->make_immutable;

1;
