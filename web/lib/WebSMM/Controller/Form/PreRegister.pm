package WebSMM::Controller::Form::PreRegister;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/form/root') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub process : Chained('base') : PathPart('preregister') : Args(0) {
    my ( $self, $c ) = @_;

    my $api  = $c->model('API');
    my $form = $c->model('Form');

    my $params = { %{ $c->req->params } };

    $api->stash_result(
        $c, ['preregister/complete'],
        method => 'POST',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok',
            [ '/', {}, 'Cadastrado com sucesso!' ] );
    }

}

__PACKAGE__->meta->make_immutable;

1;
