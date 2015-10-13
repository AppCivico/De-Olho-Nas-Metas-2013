package WebSMM::Controller::Admin::CommentGoal;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('comentario_meta') :
  CaptureArgs(0) {
    my ( $self, $c, $id ) = @_;
}

sub set_accepted : Chained('base') : PathPart('aceito') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    my $pe  = $c->req->param('pe_id');

    $api->stash_result(
        $c,
        [ 'comment_goals', $pe ],
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

    $api->stash_result(
        $c,
        [ 'comment_goals', $pe ],
        method => 'PUT',
        params => { active => 0 }
    );

    $c->res->status(200);
    $c->res->body( message => 'Removido com sucesso' );

}

__PACKAGE__->meta->make_immutable;

1;
