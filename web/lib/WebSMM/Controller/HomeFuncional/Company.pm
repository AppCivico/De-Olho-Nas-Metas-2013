package WebSMM::Controller::HomeFuncional::Company;
use Moose;
use namespace::autoclean;
use utf8;

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

sub detail : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, 'companies', params => $c->req->params );
	foreach my $n (@{$c->stash->{companies}}){
		$_ = [split /\|/, $_] for @{$n->{agg_budgets}};
	}
	use DDP; p $c->stash->{companies};
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
