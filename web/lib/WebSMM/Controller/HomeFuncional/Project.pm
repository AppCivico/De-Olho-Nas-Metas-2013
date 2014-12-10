package WebSMM::Controller::HomeFuncional::Project;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Project - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/homefuncional/base') :PathPart('project') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub object :Chained('base') :PathPart('') :CaptureArgs(1){
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    $api->stash_result(
        $c,
        [ 'projects', $id ],
        stash => 'project_obj'
    );
	

}

sub detail :Chained('object') :PathPart('') :Args(0){
    my ( $self, $c, $id ) = @_;
}

sub index :Chained('base') :PathPart('') :Args(0){
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'projects' );
}

sub type :Chained('base')  :Args(0){
    my ( $self, $c ) = @_;

	my $type_id = $c->req->params('type_id');
    my $api = $c->model('API');

    $api->stash_result( 
		$c, 'projects',
		params => { type_id => $type_id },
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
