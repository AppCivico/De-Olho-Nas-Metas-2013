package WebSMM::Controller::HomeFuncional::Goal;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Goal - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/homefuncional/base') :PathPart('goal') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');
    $api->stash_result( $c, 'objectives' );
    $api->stash_result( $c, 'regions' );

}

sub object :Chained('base') :PathPart('') :CaptureArgs(1){
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    $api->stash_result(
        $c,
        [ 'goals', $id ],
        stash => 'goal_obj'
    );

}

sub detail :Chained('object') :PathPart('') :Args(0){
    my ( $self, $c, $id ) = @_;
    my $api = $c->model('API');

}

sub index :Chained('base') :PathPart('') :Args(0){
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'goals' );

}

sub type :Chained('base')  :Args(0){
    my ( $self, $c ) = @_;

	my $type_id = $c->req->param('type_id');
    my $api = $c->model('API');

    my $res = $api->stash_result( 
		$c, 'goals',
		params => { 
			type_id => $type_id 
		}
    );
	$c->stash->{without_wrapper} = 1;
}

sub region :Chained('base')  :Args(0){
    my ( $self, $c ) = @_;

	$c->detach unless $c->req->param('region_id');
	$c->detach unless $c->req->param('region_id') =~ /^\d+$/;
	
	my $region_id = $c->req->param('region_id');
    my $api = $c->model('API');

    my $res = $api->stash_result( 
		$c, 'goals',
		params => { 
			region_id => $region_id 
		}
    );
	use DDP;
	p $c->stash->{goals};
	$c->stash->{without_wrapper} = 1;
}

sub region_by_cep :Chained('base') :Args(0) {
    my ( $self, $c ) = @_;

	$c->detach unless $c->req->param('latitude');
	$c->detach unless $c->req->param('longitude');
	
	$c->detach unless $c->req->param('latitude')  =~ qr/^(\-?\d+(\.\d+)?)$/;
	$c->detach unless $c->req->param('longitude') =~ qr/^(\-?\d+(\.\d+)?)$/;

	my $lnglat = join (q/ /,$c->req->param('longitude'),$c->req->param('latitude'));

    my $api = $c->model('API');

    my $res = $api->stash_result( 
		$c, 'goals',
		params => { 
			lnglat => $lnglat 
		}
    );
	use DDP; p $c->stash->{error};
	$c->stash->{message} = 1 if $c->stash->{error};
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
