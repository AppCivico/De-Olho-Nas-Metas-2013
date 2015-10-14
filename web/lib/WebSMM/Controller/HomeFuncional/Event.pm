package WebSMM::Controller::HomeFuncional::Event;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Event - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/homefuncional/base') : PathPart('event') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'events', $id ], stash => 'event_obj' );

}

sub detail : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c, $id ) = @_;
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'events' );
}

sub set_event : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach unless $c->req->method eq 'POST';
    my $api  = $c->model('API');
    my $form = $c->model('Form');

    my $params = { %{ $c->req->params } };
    $form->format_date_hour( $params, qw/date/ );
    $params->{description} = delete $params->{description_event};
    delete $params->{campaign_id} if $params->{campaign_id} eq 'Selecione';
    $params->{user_id} = $c->user->obj->id;

    $api->stash_result(
        $c,
        'events',
        method => 'POST',
        body   => $params,
    );
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    $c->detach(
        '/form/redirect_ok',
        [
            \'/user/perfil/campanhas', {},
            'Cadastrado com sucesso!',
            form_ident => $c->req->params->{form_ident}
        ]
    );

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
