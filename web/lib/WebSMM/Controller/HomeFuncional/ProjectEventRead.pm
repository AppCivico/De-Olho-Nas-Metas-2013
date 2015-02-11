package WebSMM::Controller::HomeFuncional::ProjectEventRead;
use Moose;
use namespace::autoclean;
use utf8;
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Project - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/homefuncional/base') :PathPart('project_event_read') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

}


sub view_notification :Chained('base') :PathPart('visualizado') :Args(0){

    my ( $self, $c ) = @_;

    my $api = $c->model('API');
	
	my $user_id    = $c->req->param('user_id');
	my $project_event_id = $c->req->param('project_event_id');
	
    $api->stash_result(
        $c,
		 'project_event_reads',
        method => 'POST',
        params   => { user_id => $user_id, project_event_id => $project_event_id }
    );
	
	$c->res->status(400),$c->detach unless $c->stash->{project_event_read_id};
	$c->res->status(200);
	$c->res->content_type('application/json');
	$c->res->body(
		$c->stash->{project_event_read_id}
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
