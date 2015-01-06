package WebSMM::Controller::HomeFuncional::Organization;
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

sub base :Chained('/homefuncional/base') :PathPart('organization') :CaptureArgs(0) {
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

    my $api = $c->model('API');

    $api->stash_result( $c, 'organizations' );
	my $group_by = {};
	push @{$group_by->{ uc(substr($_->{name}, 0, 1)) }}, $_ for @{$c->stash->{organizations}};
	push @{$group_by->{count}},scalar(@{$c->stash->{organizations}});
	use DDP;
	p %$group_by;
	$c->stash->{organizations} = $group_by;
#	p $c->stash->{organizations};
	my @order = sort keys %$group_by;
	$c->stash->{order} = \@order;
	use Data::Dumper;
	print Dumper $c->stash->{order};	
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
