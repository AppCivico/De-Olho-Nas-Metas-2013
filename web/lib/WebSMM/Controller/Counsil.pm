package WebSMM::Controller::Counsil;
use Moose;
use namespace::autoclean;
use URI;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('counsil') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    return if $c->req->method eq 'POST';

    my $api = $c->model('API');

    if ( !$c->user || !grep { /^counsil$/ } $c->user->roles ) {
        $c->detach( '/form/redirect_error', [] );
    }

    #    my $u_data = { %{ $c->user } };
    #    my $u      = $c->req->params->{change_process};

    #    if ( !$u && !$u_data->{password_defined} && grep { /^organization$/ }
    #        $c->user->roles )
    #    {
    #        $c->detach( 'Admin::Organization' => 'change_password' );
    #    }

    $c->stash->{template_wrapper} = 'counsil';

}

__PACKAGE__->meta->make_immutable;

1;
