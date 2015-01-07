package WebSMM::Controller::User::Account;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/user/base') : PathPart('') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('perfil') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

}

sub index : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

}

__PACKAGE__->meta->make_immutable;

1;
