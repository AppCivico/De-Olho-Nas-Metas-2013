package WebSMM::Controller::Admin::Organization;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('organization') : CaptureArgs(0) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'cities' );
    $c->stash->{select_cities} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{cities} } ];

    $api->stash_result( $c, 'states' );
    $c->stash->{select_states} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'organizations', $id ],
        stash => 'organization_obj'
    );

}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'organizations' );
}

sub add : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'subprefectures' );
    $api->stash_result( $c, 'organization_types' );
    use DDP;
    p $c->stash;
    $c->stash->{select_subprefectures} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{subprefectures} } ];
    $c->stash->{select_organization_types} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{organization_types} } ];

}

sub edit : Chained('object') : PathPart('') : Args(0) {
}

sub change_password : Chained('base') : PathPart('change_password') : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'admin/organization/change_password.tt';
}

__PACKAGE__->meta->make_immutable;

1;
