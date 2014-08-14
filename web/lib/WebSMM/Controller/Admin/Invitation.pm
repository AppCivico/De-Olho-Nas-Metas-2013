package WebSMM::Controller::Admin::Invitation;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('invitation') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, [ 'invitations', $id ], stash => 'invitation_obj' );

    $c->detach( '/form/not_found', [] ) if $c->stash->{invitation_obj}{error};
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, ['invitations'] );
}

sub edit : Chained('object') : PathPart('') : Args(0) {
}

sub add : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{campaign_id} = $c->req->params->{campaign_id};
}

__PACKAGE__->meta->make_immutable;

1;