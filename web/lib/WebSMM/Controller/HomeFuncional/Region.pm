package WebSMM::Controller::HomeFuncional::Region;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Region - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/homefuncional/base') : PathPart('abc') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'regions', $id ], stash => 'region_obj', );

}

sub detail : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c, $id ) = @_;
    my $api = $c->model('API');
    $api->stash_result( $c, 'regions' );
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'regions' );

}

sub get_id_region : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach unless $c->req->param('latitude');
    $c->detach unless $c->req->param('longitude');

    $c->detach unless $c->req->param('latitude') =~ qr/^(\-?\d+(\.\d+)?)$/;
    $c->detach unless $c->req->param('longitude') =~ qr/^(\-?\d+(\.\d+)?)$/;

    my $lnglat = join( q/ /, $c->req->param('longitude'), $c->req->param('latitude') );

    my $api = $c->model('API');

    my $id = $api->stash_result(
        $c,
        'regions/latlong',
        params => {
            lnglat => $lnglat,
        },
    );
}

sub region_by_id : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach unless $c->req->param('region_id');
    $c->detach unless $c->req->param('region_id') =~ qr/^\d+$/;

    my $api = $c->model('API');
    my $id  = $c->req->param('region_id');

    $api->stash_result( $c, [ 'regions', $id ], stash => 'region_obj', );
    $c->stash->{without_wrapper} = 1;
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
