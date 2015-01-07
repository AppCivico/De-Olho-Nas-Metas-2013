package SMM::Controller::API::ProjectEvent;

use Moose;
use utf8;
use List::MoreUtils qw(uniq);

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::ProjectEvent',
    object_key  => 'project_event',
    result_attr => {
        prefetch => ['project' ],
    },

    update_roles => [qw/superadmin user admin webapi/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('project_events') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $project_event = $c->stash->{project_event};
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $project_event->$_, }
                  qw/
                  id
                  text
                  ts
                  /
            ),
            project => 
                (
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
                    } $project_event->project,
                ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $project_event = $c->stash->{organization};

    $project_event->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };
    my $project_event   = $c->stash->{project_event};

    $project_event->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $project_event->id ] )->as_string,
        entity => { id => $project_event->id }
      ),
      $c->detach
      if $project_event;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{collection};

	if ($c->req->param('project_id')){
		$rs = $rs->search({ project_id => $c->req->param('project_id')});
	}
	if ( $c->req->param('approved')){
    	$rs = $rs->search(
          { approved => $c->req->param('approved'), active => 1 },
          {
			'+select' => [ \q{to_char(me.ts, 'DD/MM/YYYY HH24:MI:SS') AS process_ts}],
			'+as'     => [ 'process_ts'], 
            order_by => 'me.ts'
       	  },
    	);
	}

    $self->status_ok(
        $c,
        entity => {
            project_events => [
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
						project => 
							(
									+{
										id => $r->{project}->{id},
										name => $r->{project}->{name},
										latitude => $r->{project}->{latitude},
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

    my $project_event = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ 1 ] )->as_string,
        entity => {
            project_event_id => $project_event->id
        }
    );
}


1;
