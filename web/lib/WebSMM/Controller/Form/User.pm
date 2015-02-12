package WebSMM::Controller::Form::User;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;
use Path::Class qw(dir);

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/form/root') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub process : Chained('base') : PathPart('user') : Args(0) {
    my ( $self, $c ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };
    use DDP;
    $params->{active} = 1;

    my $avatar = $c->req->upload('avatar');
    $api->stash_result(
        $c, ['users'],
        method => 'POST',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        my @r;

        push(
            @r,
            {
                user_id => $c->stash->{id},
                role_id => 3
            }
        );

        my $roles = encode_json( \@r );

        my $path = dir( $c->config->{profile_picture_path} )->resolve . '/' . $c->stash->{id};
        unless ( -e $path ) {
            mkdir $path;
        }

        $avatar->copy_to( $path . '/' . $c->stash->{id} . '.jpg' );

        $api->stash_result(
            $c, 'roles',
            method => 'POST',
            body   => {
                roles        => $roles,
                add_relation => 1
            }
        );

        if ( $c->stash->{error} ) {
            $c->detach( '/form/redirect_error', [] );
        }
        else {
            $c->detach( '/form/redirect_ok', [ \'/login', {}, 'Cadastrado com sucesso!' ] );
        }
    }
}

sub process_edit : Chained('base') : PathPart('user') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };
    my @r;

    my $avatar = $c->req->upload('avatar');

    if ( ref $params->{roles} eq 'ARRAY' ) {

        foreach my $r ( @{ $params->{roles} } ) {
            push(
                @r,
                {
                    user_id => $id,
                    role_id => $r
                }
            );
        }

    }
    else {
        push(
            @r,
            {
                user_id => $id,
                role_id => $params->{roles}
            }
        );
    }

    my $roles = encode_json( \@r );

    my $path = dir( $c->config->{profile_picture_path} )->resolve . '/' . $c->stash->{id};

    $params->{roles}        = $roles;
    $params->{change_roles} = 1;

    $api->stash_result(
        $c, [ 'users', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/user/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_user') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'customers', $id ], method => 'DELETE' );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/admin/customer/index', {}, 'Removido com sucesso!' ] );
    }
}

sub process_user : Chained('base') : PathPart('change_password') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };

    $api->stash_result(
        $c, [ 'users', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/user/account/security', {}, 'Alterado com sucesso!' ] );
    }

}

sub process_perfil : Chained('base') : PathPart('edit_perfil') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };

    return unless $id =~ /^\d+$/;
    my $avatar = $c->req->upload('avatar');

    if ($avatar) {
        my $path = dir( $c->config->{profile_picture_path} )->resolve . '/' . $id;
        unless ( -e $path ) {
            mkdir $path;
        }
        use DDP;
        p $path;

        $avatar->copy_to( $path . '/' . $id . '.jpg' );
    }

    $api->stash_result(
        $c, [ 'users', $id ],
        method => 'PUT',
        body   => $params
    );
    use DDP;
    p $c->stash->{status_msg};
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok', [ '/user/account/edit', {}, 'Alterado com sucesso!' ] );
    }

}
__PACKAGE__->meta->make_immutable;

1;
