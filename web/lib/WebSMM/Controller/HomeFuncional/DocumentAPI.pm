package WebSMM::Controller::HomeFuncional::DocumentAPI;
use Moose;
use namespace::autoclean;
use utf8;
use List::MoreUtils qw/uniq/;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::DocumentAPI - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/homefuncional/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

}

sub index : Chained('base') : PathPart('open-data') : Args(0) {
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
