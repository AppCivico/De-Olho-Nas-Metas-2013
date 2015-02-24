package SMM::Controller::API::CommentProject;

use Moose;
use utf8;
use List::MoreUtils qw(uniq);

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::CommentProject',
    object_key  => 'comment_project',
    result_attr => {
        prefetch => [ 'user', 'project'],
    },

    update_roles => [qw/superadmin user admin webapi/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('comment_projects') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $comment_project = $c->stash->{comment_project};
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $comment_project->$_, }
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
                } $comment_project->project,
            ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $comment_project = $c->stash->{organization};

    $comment_project->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params  = { %{ $c->req->params } };
    my $comment_project = $c->stash->{comment_project};

    $comment_project->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $comment_project->id ] )
          ->as_string,
        entity => { id => $comment_project->id }
      ),
      $c->detach
      if $comment_project;
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
            comment_projects => [
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
	use DDP;
	p $c->req->params;
    my $comment_project = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'), [1] )->as_string,
        entity => {
            comment_project_id => $comment_project->id
        }
    );
}

1;
