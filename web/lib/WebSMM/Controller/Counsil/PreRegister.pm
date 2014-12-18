package WebSMM::Controller::Counsil::PreRegister;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/counsil/base') : PathPart('preregister') : CaptureArgs(0) {
    my ( $self, $c, $id ) = @_;

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {

}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'preregisters' );
}

sub add : Chained('base') : PathPart('new') : Args(0) {
}

sub edit : Chained('object') : PathPart('') : Args(0) {
}

sub change_password : Chained('base') : PathPart('change_password') : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'admin/organization/change_password.tt';
}

__PACKAGE__->meta->make_immutable;

1;
