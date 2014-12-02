package WebSMM::Controller::HomeFuncional::Campaign;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Campaign - Catalyst Controller

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


}

sub detail :Chained('object') :PathPart('') :Args(0){
    my ( $self, $c, $id ) = @_;
}

sub index :Chained('base') :PathPart('') :Args(0){
    my ( $self, $c ) = @_;


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
