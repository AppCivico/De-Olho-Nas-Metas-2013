package WebSMM::Controller::Counsil::Dashboard;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/counsil/base') : PathPart('') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('dashboard') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub index : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    my $s = $c->user->name;
}

__PACKAGE__->meta->make_immutable;

1;
