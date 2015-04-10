package SMM::Controller::API::CommentGoal;

use Moose;
use utf8;
use List::MoreUtils qw(uniq);

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::CommentGoal',
    object_key  => 'comment_goal',
    result_attr => {
        prefetch => [ 'user', 'goal' ],
    },

    update_roles => [qw/superadmin user admin webapi/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('comment_goals') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $comment_goal = $c->stash->{comment_goal};
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $comment_goal->$_, }
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
                } $comment_goal->project,
            ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $comment_goal = $c->stash->{comment_goal};

    $comment_goal->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };
    use DDP;
    p $params;
    my $comment_goal = $c->stash->{comment_goal};

    $comment_goal->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $comment_goal->id ] )
          ->as_string,
        entity => { id => $comment_goal->id }
      ),
      $c->detach
      if $comment_goal;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{collection};

    if ( $c->req->param('goal_id') ) {
        $rs = $rs->search( { goal_id => $c->req->param('goal_id') } );
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
            comment_goals => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              description
                              process_ts
                              /
                        ),
                        goal => (
                            +{
                                id   => $r->{goal}->{id},
                                name => $r->{goal}->{name},
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

    my $comment_goal = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'), [1] )->as_string,
        entity => {
            comment_goal_id => $comment_goal->id
        }
    );
}

1;
