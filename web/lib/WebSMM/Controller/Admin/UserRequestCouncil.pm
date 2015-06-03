package WebSMM::Controller::Admin::UserRequestCouncil;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('user_request_council') :
  CaptureArgs(0) {
    my ( $self, $c, $id ) = @_;
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, 'user_request_council',
        params => { user_status => 'pending' } );

}

sub set_accepted : Chained('base') : PathPart('aceito') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    my $pe  = $c->req->param('pe_id');
    $api->stash_result(
        $c,
        [ 'user_request_council', $pe ],
        method => 'PUT',
        params => { user_status => 'accepted' }
    );

    $c->res->status(200);
    $c->res->body( message => 'inserido com sucesso' );

}

sub set_removed : Chained('base') : PathPart('remover') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    my $pe  = $c->req->param('pe_id');

    $api->stash_result(
        $c,
        [ 'user_request_council', $pe ],
        method => 'PUT',
        params => { user_status => 'denied' }
    );

    $c->res->status(200);
    $c->res->body( message => 'Removido com sucesso' );

}

__PACKAGE__->meta->make_immutable;

1;
