package WebSMM::Controller::HomeFuncional::Company;
use Moose;
use namespace::autoclean;
use utf8;
use List::MoreUtils qw/uniq/;
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Company - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/homefuncional/base') : PathPart('company') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $name ) = @_;
    $c->stash->{company} = $name;
}

sub index :Chained('base') :PathPart('') :Args(0){
    my ( $self, $c ) = @_;
    my $api = $c->model('API');
    $api->stash_result( $c, 'companies' );
}
sub detail : Chained('object') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, 'companies', params => { business_name_url => $c->stash->{company} } );

    foreach my $n ( @{ $c->stash->{companies} } ) {
        $_ = [ split /\|/, $_ ] for @{ $n->{agg_budgets} };
        $n->{goals} = [ uniq @{ $n->{goals} } ];
        $_ = [ split /\|/, $_ ] for @{ $n->{goals} };

    }
    p $c->stash->{companies};
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
