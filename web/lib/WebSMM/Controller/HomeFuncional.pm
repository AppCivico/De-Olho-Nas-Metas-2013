package WebSMM::Controller::HomeFuncional;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

__PACKAGE__->config( namespace => '' );
=head1 NAME

WebSMM::Controller::HomeFuncional - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/') :PathPart('home') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub object :Chained('base') :PathPart('') :CaptureArgs(1){
    my ( $self, $c, $id ) = @_;


}

sub detail :Chained('object') :PathPart('') :Args(0){
    my ( $self, $c, $id ) = @_;
	$c->stash->{without_wrapper} = 1;
}

sub home :Chained('base') :PathPart('') :Args(0){
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'goals' );
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
