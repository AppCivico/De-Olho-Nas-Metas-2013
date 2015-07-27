package WebSMM::Controller::HomeFuncional::Company;
use Moose;
use namespace::autoclean;
use utf8;
use List::MoreUtils qw/uniq/;
use List::Util qw/sum/;
use DDP;
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Company - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/homefuncional/base') : PathPart('company') :
  CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $name ) = @_;
    my $api = $c->model('API');

    my $company =
      $api->get_result( $c, 'companies', params => { name_url => $name } );
    $c->stash->{company} = $company->{companies}[0];
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
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

sub detail : Chained('object') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c,
        [ 'companies', $c->stash->{company}->{id}, 'budgets' ] );
    $api->stash_result( $c,
        [ 'companies', $c->stash->{company}->{id}, 'goals' ] );

    $c->stash->{sum_budgets} =
      sum map { $_->{liquidated_value} } @{ $c->stash->{budgets} };
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
