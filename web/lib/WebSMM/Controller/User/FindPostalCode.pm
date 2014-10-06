package WebSMM::Controller::User::FindPostalCode;
use Moose;
use namespace::autoclean;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/user/base') : PathPart('find_postal_code') :
  CaptureArgs(0) {
}

sub index : Chained('base') : PathPart('search') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        'geolocation/find_postal_code',
        params => {
            address => $c->req->params->{address}
        }
    );

    $c->stash->{without_wrapper} = 1;
}

__PACKAGE__->meta->make_immutable;

1;
