package WebSMM::Controller::Admin::Customer;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('customer') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, [ 'customers', $id ], stash => 'customer_obj' );

    $c->detach( '/form/not_found', [] ) if $c->stash->{customer_obj}{error};
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

    $api->stash_result( $c, ['customers'] );
}

sub edit : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c )    = @_;
    my $api             = $c->model('API');

    $api->stash_result( $c, 'states' );
    $c->stash->{select_states} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];
}

sub add : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c )    = @_;
    my $api             = $c->model('API');

    $api->stash_result( $c, 'states' );
    $c->stash->{select_states} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];
}

__PACKAGE__->meta->make_immutable;

1;
