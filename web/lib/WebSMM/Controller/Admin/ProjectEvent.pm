package WebSMM::Controller::Admin::ProjectEvent;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('approved_notification') : CaptureArgs(0) {
    my ( $self, $c, $id ) = @_;

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {

}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, 'project_events', params => { approved => 'false' } );
}

sub set_accepted : Chained('base') : PathPart('aceito') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    my $pe  = $c->req->param('pe_id');

    use DDP;
    p $pe;
    $api->stash_result(
        $c,
        [ 'project_events', $pe ],
        method => 'PUT',
        params => { approved => 1 }
    );

    $c->res->status(200);
    $c->res->body( message => 'inserido com sucesso' );

}

sub set_removed : Chained('base') : PathPart('remover') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    my $pe  = $c->req->param('pe_id');

    use DDP;
    p $pe;
    $api->stash_result(
        $c,
        [ 'project_events', $pe ],
        method => 'PUT',
        params => { active => 0 }
    );

    $c->res->status(200);
    $c->res->body( message => 'desativado com sucesso' );
}

__PACKAGE__->meta->make_immutable;

1;
