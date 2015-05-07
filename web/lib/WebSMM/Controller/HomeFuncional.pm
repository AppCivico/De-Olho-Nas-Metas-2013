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

sub base : Chained('/') : PathPart('') : CaptureArgs(0) {

    my ( $self, $c ) = @_;
    my $api = $c->model('API');
    if ( $c->user ) {
        $api->stash_result(
            $c,
            [ 'users', $c->user->obj->id ],
            stash => 'user_roles',
        );
        $c->stash->{user_obj}->{role} =
          { map { $_ => 1 } @{ $c->stash->{user_roles}->{roles} } };
    }

    $c->stash->{template_wrapper} = 'func';
}

sub home : Chained('base') : PathPart('') : Args(0) {
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
