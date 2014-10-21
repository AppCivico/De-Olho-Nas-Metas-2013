package WebSMM::Controller::Admin::Form::User;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub process : Chained('base') : PathPart('user') : Args(0) {
    my ( $self, $c ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };
	use DDP;
	p$params;
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

        if ( ref $params->{roles} eq 'ARRAY' ) {
            foreach my $r ( @{ $params->{roles} } ) {
                push(
                    @r,
                    {
                        user_id => $c->stash->{id},
                        role_id => $r
                    }
                );
            }

        }
        else {
            push(
                @r,
                {
                    user_id => $c->stash->{id},
                    role_id => $params->{roles}
                }
            );
        }
        my $roles = encode_json( \@r );

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
            $c->detach( '/form/redirect_ok',
                [ '/admin/user/index', {}, 'Cadastrado com sucesso!' ] );
        }
    }
}

sub process_edit : Chained('base') : PathPart('user') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };
    my @r;
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
        $c->detach( '/form/redirect_ok',
            [ '/admin/user/index', {}, 'Alterado com sucesso!' ] );
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
        $c->detach( '/form/redirect_ok',
            [ '/admin/customer/index', {}, 'Removido com sucesso!' ] );
    }
}

__PACKAGE__->meta->make_immutable;

1;
