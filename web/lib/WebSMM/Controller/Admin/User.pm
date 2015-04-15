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
    $c->stash->{users} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{roles} } ];
    use DDP;
    p $c->stash->{roles};
    warn '1';
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
    use DDP;
    $params->{role} = "" if $params->{role} eq '--';
    p $params;
    $api->stash_result(
        $c, 'users',
        params => {
            role => $params->{role} ? $params->{role} : 99,
            filters => 1,
            params  => { name => $params->{name}, role => $params->{role} },
            order   => 'me.name'
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

    my $api = $c->model('API');

    $api->stash_result( $c, 'roles' );
    use DDP;
    p $c->stash->{organizations};
}

__PACKAGE__->meta->make_immutable;

1;
