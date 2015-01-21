package WebSMM::Controller::HomeFuncional;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

#__PACKAGE__->config( namespace => '');
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

	$c->stash->{template_wrapper} = 'func';
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
    my ( $self, $c ) = @_;
}

sub home :Chained('base') :PathPart('') :Args(0){
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'objectives' );
    $api->stash_result( $c, 'regions' );

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
