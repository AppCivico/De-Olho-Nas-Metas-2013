package WebSMM::Controller::Admin::Form::Goal;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub download : Chained('base') : PathPart('goal') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    @{ $c->stash->{header} } = (
        "Nome",
        "Descrição",
        "Descrição Técnica",
        "Objetivo de entrega",
        "Expectativa de começo",
        "Expectativa de fim",
        "Porcentagem",
        "Número da meta",
        "Progresso Qualitativo 1",
        "Progresso Qualitativo 2",
        "Progresso Qualitativo 3",
        "Progresso Qualitativo 4",
        "Progresso Qualitativo 5",
        "Progresso Qualitativo 6"
    );
}

sub csv : Chained('download') : PathPart('csv') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    $api->stash_result( $c, 'goals' );
    my %lines;

    push @{ $lines->{main} }, $c->stash->{header};
    push @{ $lines->{main} }, [ $_->{id}, $_->{name}, ],
      for @{ $c->stash->{goals} };
    $file->_download( $c, 'meta', \@lines );

}

sub xls : Chained('download') : PathPart('xls') : Args(0) {
    my ( $self, $c ) = @_;
}

sub xlsx : Chained('download') : PathPart('xlsx') : Args(0) {
    my ( $self, $c ) = @_;
}

sub process : Chained('base') : PathPart('goal') : Args(0) {
    my ( $self, $c ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };
    $api->stash_result(
        $c, ['goals'],
        method => 'POST',
        body   => $params
    );
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }

    $c->detach( '/form/redirect_ok',
        [ '/admin/goal/index', {}, 'Cadastrado com sucesso!' ] );
}

sub process_edit : Chained('base') : PathPart('goal') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };

    $api->stash_result(
        $c, [ 'goals', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok',
            [ '/admin/goal/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_goal') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'goals', $id ], method => 'DELETE' );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok',
            [ '/admin/goal/index', {}, 'Removido com sucesso!' ] );
    }
}

__PACKAGE__->meta->make_immutable;

1;
