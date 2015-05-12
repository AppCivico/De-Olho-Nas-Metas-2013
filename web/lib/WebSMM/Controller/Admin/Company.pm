package WebSMM::Controller::Admin::Company;
use Moose;
use namespace::autoclean;
use utf8;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::Admin::Company - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/admin/base') : PathPart('company') : CaptureArgs(0) {
    my ( $self, $c, $id ) = @_;

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'companies', $id ], stash => 'company_obj' );

}

sub detail : Chained('object') : PathPart('') Args(0) {
    my ( $self, $c ) = @_;
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'companies' );
    my $api = $c->model('API');

    $c->req->params->{option} ||= 'a';

    $api->stash_result(
        $c,
        'companies',
        params => {
            'name:order' => 'asc',
            ( $c->req->params->{option} ne '0..9' )
            ? ( 'name_url:like' => lc $c->req->params->{option} . '%' )
            : ( 'name_url_zero' => 1 )
        }
    );
    for my $carac ( 'A' .. 'Z' ) {
        push( @{ $c->stash->{options} }, $carac );
    }
    push( @{ $c->stash->{options} }, '0..9' );

}

sub add : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;

}

sub edit : Chained('object') : PathPart('edit') : Args(0) {
    my ( $self, $c, $id ) = @_;
    my $api = $c->model('API');
    $api->stash_result( $c, 'companies' );
    $c->stash->{select_companies} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{companies} } ];

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
