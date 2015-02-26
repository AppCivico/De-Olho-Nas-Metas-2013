package WebSMM::Controller::User::Account;
use Moose;
use namespace::autoclean;
use JSON;
use utf8;
use URI;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/user/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');
    $api->stash_result( $c, [ 'users', $c->user->obj->id ], stash => 'user_roles', );

}

sub object : Chained('base') : PathPart('perfil') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub index : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach( '/form/redirect_error', [] ) unless $c->user;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'users/user_project_event', $c->user->obj->id ], stash => 'user_obj', );
    $c->stash->{user_obj}->{role} = { map { $_ => 1 } @{ $c->stash->{user_roles}->{roles} } };

}

sub security : Chained('object') : PathPart('seguranca') : Args(0) {
    my ( $self, $c ) = @_;

    return unless $c->req->method eq 'POST';

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'users', $c->user->id ],
        method => 'PUT',
        params => $c->req->params,
    );

}

sub edit : Chained('object') : PathPart('editar') : Args(0) {
    my ( $self, $c ) = @_;

    return unless $c->req->method eq 'POST';

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'users', $c->user->id ],
        method => 'PUT',
        params => $c->req->params,
    );

}

sub survey : Chained('object') : PathPart('enquete') : Args(0) {
    my ( $self, $c ) = @_;

    my $return;
    my $res;

    my $model = $c->model('API');

    my $url = URI->new('http://dev.monitor.promisetracker.org');

	$url->path_segments('api','v1','campaigns');
	use DDP;
	p $url;
    eval {
        $return = $model->_do_http_req(
            method  => 'GET',
            url     => $url,
            headers => [ Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201' ],
        );
    };

    my $data = decode_json $return->content;
	p $data;
    $c->stash->{campaigns} = $data->{payload};

}
sub survey_single : Chained('object') : PathPart('enquete') : Args(1) {
    my ( $self, $c , $id) = @_;

    my $return;
    my $res;

    my $model = $c->model('API');

    my $url = URI->new('http://dev.monitor.promisetracker.org');

	$url->path_segments('api','v1','campaigns',$id);
	use DDP;
	p $url;
    eval {
        $return = $model->_do_http_req(
            method  => 'GET',
            url     => $url,
            headers => [ Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201' ],
        );
    };

    my $data = decode_json $return->content;
    $c->stash->{campaign} = $data;

}
sub follow : Chained('object') : PathPart('seguindo') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'users', $c->user->id ], stash => 'user_obj', );
    use DDP;
    p $c->stash->{user_obj};
}

sub invite : Chained('object') : PathPart('convidar') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

}

sub notification : Chained('object') : PathPart('notificacoes') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach( '/form/redirect_error', [] ) unless $c->user;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'users/user_project_event_all', $c->user->obj->id ], stash => 'user_obj', );
    use DDP;
    p $c->stash->{user_obj};
    $c->stash->{user_obj}->{role} = { map { $_ => 1 } @{ $c->stash->{user_obj}->{roles} } };

}
__PACKAGE__->meta->make_immutable;

1;
