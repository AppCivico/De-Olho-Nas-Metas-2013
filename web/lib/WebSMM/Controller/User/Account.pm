package WebSMM::Controller::User::Account;
use Moose;
use namespace::autoclean;
use JSON;
use utf8;
use URI;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/user/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template_wrapper} = 'func';
    my $api = $c->model('API');
    $api->stash_result(
        $c,
        [ 'users', $c->user->obj->id ],
        stash => 'user_roles',
    );
    $c->stash->{user_obj}->{role} =
      { map { $_ => 1 } @{ $c->stash->{user_roles}->{roles} } };
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

sub campaign_param : Chained('object') : PathPart('campanha') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    $c->detach( '/form/redirect_error', [] ) unless $c->user;

    $c->stash->{id} = $id;
}

sub campaign_edit : Chained('campaign_param') : PathPart('editar') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'campaigns', $c->stash->{id} ],
        stash => 'campaign_obj'
    );
}

sub campaign_remove : Chained('campaign_param') : PathPart('remover') : Args(0)
{
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'campaigns', $c->stash->{id} ],
        method => 'DELETE',
        stash  => 'campaign_obj'
    );
    $c->detach(
        '/form/redirect_ok',
        [

            '/user/account/campaign',
            {},
            'Removido com sucesso!',

        ]
    );

}

sub campaign_update : Chained('campaign_param') : PathPart('atualizar') :
  Args(0) {
    my ( $self, $c ) = @_;
    use DDP;

    my $api    = $c->model('API');
    my $form   = $c->model('Form');
    my $params = { %{ $c->req->params } };

    my $avatar = $c->req->upload('avatar');

    $form->format_date( $params, qw/end_on start_in/ );

    $params->{latlng} =~ s/\(|\)//g if $params->{latlng};
    if ( $params->{latlng} ) {
        ( $params->{latitude}, $params->{longitude} ) = split ',',
          $params->{latlng};
    }
    p $params;
    $params->{address} = delete $params->{txtaddress};

    p $c->req->params;
    $api->stash_result(
        $c,
        [ 'campaigns', $c->stash->{id} ],
        method => 'PUT',
        stash  => 'campaign_obj',
        body   => $params
    );
    my $path = dir( $c->config->{campaign_picture_path} )->resolve . '/'
      . $c->stash->{id};

    unless ( -e $path ) {
        mkdir $path;
    }

    $avatar->copy_to( $path . '/' . $c->stash->{id} . '.jpg' ) if $avatar;

    $c->detach(
        '/form/redirect_ok',
        [

            '/user/account/campaign',
            {},
            'Alterado com sucesso!',

        ]
    );
}

sub campaign : Chained('object') : PathPart('campanhas') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach( '/form/redirect_error', [] ) unless $c->user;

    my $api = $c->model('API');

    $api->stash_result( $c, 'campaigns',
        params => { user_id => $c->user->obj->id } );
    my $return;
    my $url = URI->new('http://monitor.promisetracker.org');

    $url->path_segments( 'api', 'v1', 'campaigns' );

    $url->query_form( user_id => $c->user->obj->organization_id );
    eval {
        $return = $api->_do_http_req(
            method  => 'GET',
            url     => $url,
            headers => [
                Authorization => 'Token token="dd6aba6936baf78d329979564d2fb58c'
            ],

        );
    };

    my $data = decode_json $return->content;

    for my $p ( @{ $data->{payload} } ) {
        push @{ $c->stash->{mobile_campaigns} },
          { id => $p->{id}, description => $p->{description} }
          if $p->{description};
    }
    use DDP;
    p $c->stash->{mobile_campaigns};
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

    my $url = URI->new('http://monitor.promisetracker.org');

    $url->path_segments( 'api', 'v1', 'campaigns' );
    $url->query_form( user_id => $id );
    eval {
        $return = $model->_do_http_req(
            method  => 'GET',
            url     => $url,
            headers => [
                Authorization => 'Token token="dd6aba6936baf78d329979564d2fb58c'
            ],

        );
    };

    use DDP;
    p $c->stash->{user_roles};

    unless ( $return->code eq 200 or $return->code eq 404 ) {
        $c->stash->{error_msg} =
"Não foi possível conectar ao sistema de campanhas móveis, por favor tente mais tarde.";

        $c->detach;
    }

    my $data = decode_json $return->content;

    $c->stash->{campaigns} = $data->{payload};

}

sub survey_single : Chained('survey') : PathPart('detalhe') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $return;
    my $res;

    my $model = $c->model('API');

    #my $url = URI->new('http://monitor.dev.promisetracker.org');
    my $url = URI->new('http://monitor.promisetracker.org');

    $url->path_segments( 'api', 'v1', 'campaigns', $id );
    $url->query_form( user_id => $c->user->obj->organization_id );
    eval {
        $return = $model->_do_http_req(
            method  => 'GET',
            url     => $url,
            headers => [

               #Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201'
                Authorization => 'Token token="dd6aba6936baf78d329979564d2fb58c'
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

    #my $url = URI->new('http://monitor.dev.promisetracker.org');
    my $url = URI->new('http://monitor.promisetracker.org');

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

               #Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201'
                Authorization => 'Token token="dd6aba6936baf78d329979564d2fb58c'
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

    #my $url = URI->new('http://monitor.dev.promisetracker.org');
    my $url = URI->new('http://monitor.promisetracker.org');

    $url->path_segments( 'api', 'v1', 'users', 'sign_in' );
    $url->query_form(
        username    => $organization_name,
        user_id     => $organization_id,
        campaign_id => $id,

        #        token       => 'c687bd99026769a662e9fc84f5c4e201',
        token  => 'dd6aba6936baf78d329979564d2fb58c',
        locale => 'pt-BR'
    );

    $c->res->redirect($url);

}

sub survey_create : Chained('survey') : PathPart('criar') : Args(0) {
    my ( $self, $c, $id ) = @_;

    my $return;
    my $res;

    my $model = $c->model('API');

    #my $url = URI->new('http://monitor.dev.promisetracker.org');
    my $url = URI->new('http://monitor.promisetracker.org');

    $url->path_segments( 'api', 'v1', 'campaigns' );
    $url->query_form(
        username => $c->stash->{user_roles}->{organization}->{name},
        user_id  => $c->user->obj->organization_id
    );

    eval {
        $return = $model->_do_http_req(
            method  => 'POST',
            url     => $url,
            headers => [

               #Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201'
                Authorization => 'Token token="dd6aba6936baf78d329979564d2fb58c'
            ],
        );
    };
    my $data = decode_json $return->content;
    $c->detach( '/form/redirect_error', [] )
      unless $data->{status} eq 'success';

    $c->res->redirect( $data->{payload}->{redirect_link} );
    $c->res->headers->header(

        #Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201' );
        Authorization => 'Token token="dd6aba6936baf78d329979564d2fb58c'
    );

}

sub counsil : Chained('object') : PathPart('conselho') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'organizations', $c->user->obj->organization_id ],
        stash => 'organization_obj',
    );
    use DDP;
    p $c->stash->{organization_obj};
    $c->stash->{user_obj}->{role} =
      { map { $_ => 1 } @{ $c->stash->{user_roles}->{roles} } };
}

sub follow : Chained('object') : PathPart('seguindo') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'users', $c->user->id ], stash => 'user_obj', );

    use DDP;
    p $c->stash->{user_obj};
    warn 1;
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
