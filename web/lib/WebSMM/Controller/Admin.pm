package WebSMM::Controller::Admin;
use Moose;
use namespace::autoclean;
use URI;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('admin') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    
	my $api = $c->model('API');
	
    if ( !$c->user || !grep { /^admin|organization$/ } $c->user->roles ) {
        $c->detach( '/form/redirect_error', [] );
    }
    
    my $u_data 	= { %{ $c->user } };
    my $u 		= $c->req->params->{change_process};
    
    if( !$u && !$u_data->{password_defined} && grep { /^organization$/ } $c->user->roles ) {
		$c->detach( 'Admin::Organization' => 'change_password' );
    }

    if( grep {/^organization$/} $c->user->roles ) {
    	$api->stash_result(
			$c, 'organizations',
			params => { id => $c->user->organization_id },
		);
    }

    $c->stash->{template_wrapper} = 'admin';

    if ( $c->req->method eq 'POST' ) {
        return;
    }

}

__PACKAGE__->meta->make_immutable;

1;
