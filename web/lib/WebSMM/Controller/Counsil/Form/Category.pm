package WebSMM::Controller::Counsil::Form::Category;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/counsil/form/base') : PathPart('') : CaptureArgs(0) {
}

sub process : Chained('base') : PathPart('category') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c, 'categories',
        method => 'POST',
        body   => $c->req->params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/category/index', {}, 'Cadastrado com sucesso!' ] );
    }

}

sub process_edit : Chained('base') : PathPart('category') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };

    $api->stash_result(
        $c, [ 'categories', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/category/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_category') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'categories', $id ], method => 'DELETE' );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/category/index', {}, 'Removido com sucesso!' ] );
    }
}

__PACKAGE__->meta->make_immutable;

1;
