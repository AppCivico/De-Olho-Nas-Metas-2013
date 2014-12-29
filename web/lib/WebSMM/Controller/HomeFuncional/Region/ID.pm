package WebSMM::Controller::HomeFuncional::Region::ID;
use Moose;
use namespace::autoclean;
use JSON;

BEGIN { extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config( default => 'application/json' );
=head1 NAME

WebSMM::Controller::HomeFuncional::Region::ID - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub id :Chained('/homefuncional/region/base') :Args(0) {
    my ( $self, $c ) = @_;
	
	$c->detach unless $c->req->param('latitude');
	$c->detach unless $c->req->param('longitude');
	
	$c->detach unless $c->req->param('latitude')  =~ qr/^(\-?\d+(\.\d+)?)$/;
	$c->detach unless $c->req->param('longitude') =~ qr/^(\-?\d+(\.\d+)?)$/;

	my $lnglat = join (q/ /,$c->req->param('longitude'),$c->req->param('latitude'));

    my $api = $c->model('API');
	
	$api->stash_result( 
		$c, 'regions/latlong',
		params => {
			lnglat => $lnglat, 
		},
		stash => 'region',
	 );
	$self->status_ok(
		$c,
		entity => { id => $c->stash->{region}->{region_id} }
	);
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
