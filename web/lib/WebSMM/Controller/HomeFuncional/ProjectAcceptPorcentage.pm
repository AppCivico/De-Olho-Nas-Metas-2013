package WebSMM::Controller::HomeFuncional::ProjectAcceptPorcentage;
use Moose;
use namespace::autoclean;
use JSON;
use Path::Class qw(dir);
use utf8;
use DDP;
BEGIN { extends 'Catalyst::Controller::REST'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::ProjectAcceptPorcentage - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/homefuncional/base') :
  PathPart('project_accept_porcentage') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    my $user_id = $c->user->obj->id if $c->user;

    my $params = { %{ $c->req->params } };

    $c->stash->{project_id} = $id;

    my $api = $c->model('API');
    $api->stash_result(
        $c,
        'project_accept_porcentage',
        method => 'POST',
        stash  => 'pap_obj',
        params => {
            project_id => $id,
            user_id    => $user_id,
            accepted   => $params->{accepted}
        }
    );
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    $self->status_ok( $c,
        entity => { message => 'Sua avaliação foi inserida com sucesso.' } );
}

sub insert : Chained('object') : PathPart('accepted') : Args(0) :
  ActionClass('REST') {
    my ( $self, $c ) = @_;
}

sub insert_POST {
    my ( $self, $c ) = @_;

}

=encoding utf8

=head1 AUTHOR

development,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
