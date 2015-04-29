package SMM::Controller::API::UserRequestCouncil;

use Moose;
use utf8;
use DDP;
use List::Util qw/sum/;
use Math::Round qw/round/;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::UserRequestCouncil',
    object_key => 'urc',
    search_ok  => {
        id => 'Int'
    },
    result_attr => {
        prefetch => [ 'user', 'organization' ],

    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('user_request_council') :
  CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;
    my $urc = $c->stash->{urc};

    $self->status_ok(
        $c,
        entity => {
            (
                id           => $urc->id,
                user_id      => $urc->user->id,
                user_name    => $urc->user->name,
                council_id   => $urc->organization->id,
                council_name => $urc->organization->name,
            ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $project = $c->stash->{organization};

    $project->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };
    my $urc    = $c->stash->{urc};

    $urc->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $urc->id ] )->as_string,
        entity => { id => $urc->id }
      ),
      $c->detach
      if $urc;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{collection};
    if ( $c->req->param('user_status') ) {
        $rs = $rs->search( { user_status => $c->req->param('user_status') } );
    }
    $rs = $rs->search(
        undef,
        {
            order_by => 'user.name'
        },
    );

    $self->status_ok(
        $c,
        entity => {
            user_request_councils => [
                map {
                    my $r = $_;
                    +{
                        (
                            id                => $r->{id},
                            user_id           => $r->{user}->{id},
                            user_name         => $r->{user}->{name},
                            user_email        => $r->{user}->{email},
                            organization_id   => $r->{organization}->{id},
                            organization_name => $r->{organization}->{name},
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

    my $project = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $project->id ] )
          ->as_string,
        entity => {
            id => $project->id
        }
    );
}

1;
