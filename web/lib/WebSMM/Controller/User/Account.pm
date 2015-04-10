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
    $api->stash_result(
        $c,
        [ 'users', $c->user->obj->id ],
        stash => 'user_roles',
    );
    use DDP;
    p $c->stash->{user_roles};
}

sub object : Chained('base') : PathPart('perfil') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub index : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach( '/form/redirect_error', [] ) unless $c->user;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'users/user_project_event', $c->user->obj->id ],
        stash => 'user_obj',
    );

    $c->stash->{user_obj}->{role} =
      { map { $_ => 1 } @{ $c->stash->{user_roles}->{roles} } };
    use DDP;
    p $c->stash->{user_obj};
    $c->detach( '/form/redirect_ok', ['/admin/dashboard/index'] )
      if $c->stash->{user_obj}->{role}->{admin};

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

sub campaign : Chained('object') : PathPart('campanhas') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach( '/form/redirect_error', [] ) unless $c->user;

    my $api = $c->model('API');

    $api->stash_result( $c, 'campaigns',
        params => { user_id => $c->user->obj->id } );

    $api->stash_result( $c, 'goals' );

    $c->stash->{user_obj}->{role} =
      { map { $_ => 1 } @{ $c->stash->{user_roles}->{roles} } };
}

sub counsil_members : Chained('object') : PathPart('membros') : Args(0) {
    my ( $self, $c ) = @_;

    return unless $c->req->method eq 'GET';

    my $api = $c->model('API');
    $api->stash_result(
        $c,
        ['users'],
        method => 'GET',
        params => $c->req->params,
    );

}

sub survey : Chained('object') : PathPart(enquete) : CaptureArgs(0) {
}

sub survey_list : Chained('survey') : PathPart('') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $return;
    my $res;

    my $model = $c->model('API');

    my $url = URI->new('http://monitor.dev.promisetracker.org');

    $url->path_segments( 'api', 'v1', 'campaigns' );
    $url->query_form( user_id => $id );
    eval {
        $return = $model->_do_http_req(
            method  => 'GET',
            url     => $url,
            headers => [
                Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201'
            ],

        );
    };

    use DDP;
    p $return;
    $c->stash->{error_msg} =
"Não foi possível conectar ao sistema de campanhas móveis, por favor tente mais tarde.",
      $c->detach
      unless $return->code eq 200;

    my $data = decode_json $return->content;

    $c->stash->{campaigns} = $data->{payload};

}

sub survey_single : Chained('survey') : PathPart('detalhe') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $return;
    my $res;

    my $model = $c->model('API');

    my $url = URI->new('http://monitor.dev.promisetracker.org');

    $url->path_segments( 'api', 'v1', 'campaigns', $id );
    $url->query_form( user_id => $c->user->obj->organization_id );
    eval {
        $return = $model->_do_http_req(
            method  => 'GET',
            url     => $url,
            headers => [
                Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201'
            ],
        );
    };
    use DDP;
    p $return;
    my $data = decode_json $return->content;
    $c->stash->{campaign} = $data->{payload};

}

sub survey_clone : Chained('survey') : PathPart('clonar') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $return;
    my $res;

    my $model = $c->model('API');

    my $url = URI->new('http://monitor.dev.promisetracker.org');

    my $organization_name = $c->stash->{user_roles}->{organization}->{name};
    my $organization_id   = $c->stash->{user_roles}->{organization}->{id};

    $url->path_segments( 'api', 'v1', 'campaigns' );
    $url->query_form(
        username    => $organization_name,
        user_id     => $organization_id,
        campaign_id => $id
    );

    eval {
        $return = $model->_do_http_req(
            method  => 'POST',
            url     => $url,
            headers => [
                Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201'
            ],
        );
    };

    my $data = decode_json $return->content;
    $c->detach( '/form/redirect_error', [] )
      unless $data->{status} eq 'success';

    $c->res->redirect( $data->{payload}->{redirect_link} );

}

sub survey_login : Chained('survey') : PathPart('entrar') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $return;
    my $res;

    my $model = $c->model('API');

    my $organization_name = $c->stash->{user_roles}->{organization}->{name};
    my $organization_id   = $c->stash->{user_roles}->{organization}->{id};

    my $url = URI->new('http://monitor.dev.promisetracker.org');

    $url->path_segments( 'api', 'v1', 'users', 'sign_in' );
    $url->query_form(
        username    => $organization_name,
        user_id     => $organization_id,
        campaign_id => $id,
        token       => 'c687bd99026769a662e9fc84f5c4e201',
        locale      => 'pt-BR'
    );

    $c->res->redirect($url);

}

sub survey_create : Chained('survey') : PathPart('criar') : Args(0) {
    my ( $self, $c, $id ) = @_;

    my $return;
    my $res;

    my $model = $c->model('API');

    my $url = URI->new('http://monitor.dev.promisetracker.org');

    $url->path_segments( 'api', 'v1', 'campaigns' );
    $url->query_form(
        username => $c->user->obj->name,
        user_id  => $c->user->obj->organization_id
    );

    eval {
        $return = $model->_do_http_req(
            method  => 'POST',
            url     => $url,
            headers => [
                Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201'
            ],
        );
    };
    my $data = decode_json $return->content;
    $c->detach( '/form/redirect_error', [] )
      unless $data->{status} eq 'success';

    $c->res->redirect( $data->{payload}->{redirect_link} );
    $c->res->headers->header(
        Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201' );

}

sub counsil : Chained('object') : PathPart('conselho') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'organizations', $c->user->obj->organization_id ],
        stash => 'organization_obj',
    );
    $c->stash->{user_obj}->{role} =
      { map { $_ => 1 } @{ $c->stash->{user_roles}->{roles} } };
}

sub follow : Chained('object') : PathPart('seguindo') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'users', $c->user->id ], stash => 'user_obj', );
}

sub invite : Chained('object') : PathPart('convidar') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

}

sub notification : Chained('object') : PathPart('notificacoes') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach( '/form/redirect_error', [] ) unless $c->user;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'users/user_project_event_all', $c->user->obj->id ],
        stash => 'user_obj'
    );
    $c->stash->{user_obj}->{role} =
      { map { $_ => 1 } @{ $c->stash->{user_obj}->{roles} } };

}
__PACKAGE__->meta->make_immutable;

1;
