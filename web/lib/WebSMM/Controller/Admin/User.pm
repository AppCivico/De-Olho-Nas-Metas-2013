package WebSMM::Controller::Admin::User;
use Moose;
use namespace::autoclean;
use POSIX;
BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('user') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, 'roles' );
    $api->stash_result( $c, 'organizations' );
    $c->stash->{select_roles} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{roles} } ];
    $c->stash->{select_organizations} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{organizations} } ];

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'users', $id ], stash => 'user_obj' );
    my %ar = map { $_ => 1 } @{ $c->stash->{user_obj}{role_ids} };
    $c->stash->{active_roles} = \%ar;

    $c->detach( '/form/not_found', [] ) if $c->stash->{user_obj}{error};
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };
    $params->{role} = "" if $params->{role} eq '--';
    $api->stash_result(
        $c, 'users',
        params => {
            role => $params->{role} ? $params->{role} : 99,
            filters  => 1,
            name     => $params->{name},
            role     => $params->{role},
            start_in => $params->{start_in},
            end_on   => $params->{end_on},
            order    => 'me.name'
        }
    );

}

sub edit : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'roles' );
    my $r = $c->stash->{active_roles};
    $c->stash->{roles} =
      [ map { { id => $_->{id}, name => $_->{name} } }
          @{ $c->stash->{roles} } ];
}

sub add : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;

}

__PACKAGE__->meta->make_immutable;

1;
