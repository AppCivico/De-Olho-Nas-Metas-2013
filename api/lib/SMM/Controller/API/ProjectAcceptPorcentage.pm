package SMM::Controller::API::ProjectAcceptPorcentage;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::ProjectAcceptPorcentage',
    object_key => 'pap',
    search_ok  => {
        id => 'Int'
    },
    result_attr => {
        prefetch => ['projects'],
    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('project_accept_porcentage') :
  CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;
    my $project_accept_porcentage = $c->stash->{project_accept_porcentage};

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $project_accept_porcentage->$_, }
                  qw/
                  id
                  project_id
                  name_image
                  /
            ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $project_accept_porcentage = $c->stash->{organization};

    $project_accept_porcentage->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params                    = { %{ $c->req->params } };
    my $project_accept_porcentage = $c->stash->{pap};

    $project_accept_porcentage->execute(
        $c,
        for  => 'update',
        with => $c->req->params
    );

    $self->status_accepted(
        $c,
        location => $c->uri_for( $self->action_for('result'),
            [ $project_accept_porcentage->id ] )->as_string,
        entity => { id => $project_accept_porcentage->id }
      ),
      $c->detach
      if $project_accept_porcentage;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;

    my $rs = $c->stash->{collection};

    $self->status_ok(
        $c,
        entity => {
            project_accept_porcentages => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              project_id
                              name_image
                              /
                        ),
                        url => $c->uri_for_action( $self->action_for('result'),
                            [ $r->{id} ] )->as_string
                      }
                } $rs->as_hashref->all
            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;

    my $project_accept_porcentage = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'),
            [ $project_accept_porcentage->id ] )->as_string,
        entity => {
            id => $project_accept_porcentage->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $project_accept_porcentage;

    $c->model('DB')->txn_do(
        sub {
            $project_accept_porcentage = $c->stash->{collection}
              ->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active} = 1;
            $c->req->params->{role}   = 'project_accept_porcentage';
            $c->req->params->{project_accept_porcentage_id} =
              $project_accept_porcentage->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'),
            [ $project_accept_porcentage->id ] )->as_string,
        entity => {
            id => $project_accept_porcentage->id
        }
    );

}

1;
