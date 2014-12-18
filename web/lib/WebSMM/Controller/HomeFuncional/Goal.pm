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

    $api->stash_result( $c, 'regions' );
    $api->stash_result( $c, 'objectives' );
}

sub index :Chained('base') :PathPart('') :Args(0){
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'goals' );
    $api->stash_result( $c, 'objectives' );

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
