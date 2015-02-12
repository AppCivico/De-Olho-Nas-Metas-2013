package SMM::Controller::API::Comment;

use Moose;
use utf8;
use List::MoreUtils qw(uniq);

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::Comment',
    object_key  => 'comment',
    result_attr => {
        prefetch => [ 'user', 'project' ],
    },

    update_roles => [qw/superadmin user admin webapi/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('comments') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $comment = $c->stash->{comment};
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $comment->$_, }
                  qw/
                  id
                  description
                  timestamp
                  /
            ),
            project => (
                map {
                    my $p = $_;
                    (
                        map {
                            { $_ => $p->$_ }
                          } qw/
                          id
                          name
                          latitude
                          longitude
                          region_id
                          /
                      ),
                } $comment->project,
            ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $comment = $c->stash->{organization};

    $comment->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params  = { %{ $c->req->params } };
    my $comment = $c->stash->{comment};

    $comment->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $comment->id ] )
          ->as_string,
        entity => { id => $comment->id }
      ),
      $c->detach
      if $comment;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{collection};

    if ( $c->req->param('project_id') ) {
        $rs = $rs->search( { project_id => $c->req->param('project_id') } );
    }
    if ( $c->req->param('approved') ) {
        $rs = $rs->search(
            { approved => $c->req->param('approved'), 'me.active' => 1 },
            {
                '+select' => [
                    \q{to_char(me.timestamp, 'DD/MM/YYYY HH24:MI:SS') AS process_ts}
                ],
                '+as'    => ['process_ts'],
                order_by => 'me.timestamp'
            },
        );
    }

    $self->status_ok(
        $c,
        entity => {
            comments => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              text
                              process_ts
                              /
                        ),
                        project => (
                            +{
                                id        => $r->{project}->{id},
                                name      => $r->{project}->{name},
                                latitude  => $r->{project}->{latitude},
                                longitude => $r->{project}->{longitude},
                            }
                        ),
                      }
                } $rs->as_hashref->all
            ]
        }
    );

}

sub list_POST {
    my ( $self, $c ) = @_;

    my $comment = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'), [1] )->as_string,
        entity => {
            comment_id => $comment->id
        }
    );
}

1;
