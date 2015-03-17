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

sub base : Chained('/homefuncional/base') : PathPart('campaign') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

	my $api = $c->model('API');

	$api->stash_result(
        $c,
        [ 'campaigns', $id ],
		stash => 'campaign_obj'
    );

}

sub detail : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c, $id ) = @_;
	use DDP; p $c->stash->{campaign_obj};
	$c->stash->{view} = $c->view('TT');
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
	my $api = $c->model('API');
	$api->stash_result(
        $c,
        'campaigns'
    );

	use DDP; p $c->stash->{campaigns};
}

sub set_campaign :Chained('base') :Args(0){
    my ( $self, $c ) = @_;

	$c->detach unless $c->req->method eq 'POST';
	my $api = $c->model('API');


    my $params = { %{ $c->req->params } };


	$params->{user_id} = $c->user->obj->id;

	$api->stash_result(
        $c,
        'campaigns',
        method => 'POST',
        body => $params,
    );
	if ($c->stash->{error}){
		$c->detach('/form/redirect_error', []);
	}
    $c->detach(
                '/form/redirect_ok',
                [
                    \'/user/perfil/campanhas', {}, 'Cadastrado com sucesso!', form_ident => $c->req->params->{form_ident}
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
