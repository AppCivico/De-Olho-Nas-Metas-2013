package SMM::Controller::API::Event;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Event',
    object_key => 'events',
    search_ok  => {
        id => 'Int'
    },
    result_attr => {
        prefetch => ['campaign'],
    },
    update_roles  => [qw/superadmin user admin webapi organization/],
    create_roles  => [qw/superadmin admin webapi/],
    delete_roles  => [qw/superadmin admin webapi/],
    before_delete => sub {

    }
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('events') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;
    my $events = $c->stash->{events};

    $self->status_ok(
        $c,
        entity => {
            (
                map {
                        $_ => ref $events->$_ eq 'DateTime'
                      ? $events->$_->datetime
                      : $events->$_
                  } qw/
                  id
                  name
                  description
                  date
                  created_at
                  campaign_id
                  user_id
                  /
            ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $events = $c->stash->{organization};

    $events->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };
    my $events = $c->stash->{organization};

    $events->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $events->id ] )
          ->as_string,
        entity => { id => $events->id }
      ),
      $c->detach
      if $events;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;

    my $rs = $c->stash->{collection};

    if ( $c->req->param('organization_id') ) {
        $rs = $rs->search(
            { 'me.council_id' => $c->req->param('organization_id') } );
    }
    $self->status_ok(
        $c,
        entity => {
            events => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              description
                              date
                              campaign_id
                              created_at
                              user_id
                              /
                        ),
                      }
                } $rs->as_hashref->all
            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;

    my $events = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $events->id ] )
          ->as_string,
        entity => {
            id => $events->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $events;

    $c->model('DB')->txn_do(
        sub {
            $events = $c->stash->{collection}
              ->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}    = 1;
            $c->req->params->{role}      = 'events';
            $c->req->params->{events_id} = $events->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $events->id ] )
          ->as_string,
        entity => {
            id => $events->id
        }
    );

}

1;
