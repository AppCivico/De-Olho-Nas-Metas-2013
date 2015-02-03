package WebSMM::Controller::HomeFuncional::Map;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config( default => 'application/json',);

=head1 NAME

WebSMM::Controller::HomeFuncional::Goal - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/homefuncional/base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

}


sub project_map_list :Chained('base') :Args(0) :ActionClass('REST'){}

sub project_map_list_GET{
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
	my $id;

	if ($c->req->param('id') =~ /^\d+$/){
       $id = $c->req->param('id');
	}else{
		$c->detach;
	} 
    $api->stash_result( $c, 
		['goals', $id],
		stash => 'goal_obj',
	 );
	$self->status_ok( $c, entity => $c->stash->{goal_obj} );
	
}
sub project_map :Chained('base') :Args(0) :ActionClass('REST') {}

sub project_map_GET {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'projects' );
	
	$self->status_ok( $c, entity => $c->stash->{projects} );

}

sub project_map_single :Chained('base') :Args(0) :ActionClass('REST') {}
sub project_map_single_GET{
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
	my $id;

	if ($c->req->param('id') =~ /^\d+$/){
       $id = $c->req->param('id');
	}else{
		$c->detach;
	} 
    $api->stash_result( 
		$c, 
		'projects/geom',
		params => { project_id => $id },
	 );

	$self->status_ok( $c, entity => $c->stash->{geom} );
	
}

sub region_project :Chained('base') :Args(0) :ActionClass('REST') {}

sub region_project_GET{
    my ( $self, $c ) = @_;

	$c->detach unless $c->req->param('id');
	$c->detach unless $c->req->param('id') =~ qr/^\d+$/;

    my $api = $c->model('API');
	my $id = $c->req->param('id');

    $api->stash_result(
        $c,
        'regions/geom',
		params => {
			region_id => $id, 
		},
    );
	$self->status_ok( $c, entity => $c->stash->{geom} );
}

sub subpref_region :Chained('base') :Args(0) :ActionClass('REST') {}

sub subpref_region_GET{
    my ( $self, $c ) = @_;

	$c->detach unless $c->req->param('id');
	$c->detach unless $c->req->param('id') =~ qr/^\d+$/;

    my $api = $c->model('API');
	my $id = $c->req->param('id');

    $api->stash_result(
        $c,
        'subprefectures/geom',
		params => {
			subprefecture_id => $id, 
		},
    );
	$self->status_ok( $c, entity => $c->stash->{geom} );
}

sub getregions :Chained('base') :Args(0) :ActionClass('REST') {}

sub getregions_GET{
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'regions/regions_map'],
        stash => 'region_obj',
    );
	$self->status_ok( $c, entity => $c->stash->{region_obj} );

}

sub subpref_org :Chained('base') :Args(0) :ActionClass('REST') {}

sub subpref_org_GET{
    my ( $self, $c ) = @_;

	$c->detach unless $c->req->param('id');
	$c->detach unless $c->req->param('id') =~ qr/^\d+$/;

    my $api = $c->model('API');
	my $id = $c->req->param('id');

    $api->stash_result(
        $c,
        ['organizations', $id ],
		stash => 'org_obj',
    );
	$self->status_ok( $c, entity => $c->stash->{org_obj} );
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
