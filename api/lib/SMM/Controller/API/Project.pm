package SMM::Controller::API::Project;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::Project',
    object_key  => 'project',
    search_ok => {
        id => 'Int'
    },
    result_attr => {
        prefetch => [ { 'goal_projects' => 'goal' }, 'region' ]
    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('projects') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $project = $c->stash->{project};
	use DDP;
	
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $project->$_, }
                  qw/
                  name
                  address
                  latitude
				  longitude
                  /
            ),
			goal => [
                (
                    map {
                        my $p = $_;
                        (
                            map {
                                { $_ => $p->goal->$_ }
                              } qw/
                              name
                              /
                          ),
                    } $project->goal_projects,
                ),
            ],

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

    my $params       = { %{ $c->req->params } };
    my $project = $c->stash->{organization};

    $project->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $project->id ] )
          ->as_string,
        entity => { id => $project->id }
      ),
      $c->detach
      if $project;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
	my $rs = $c->stash->{collection};

	if ( $c->req->param('type_id')) {
		$c->detach unless $c->req->param('type_id') =~ /^\d+$/;

		$rs = $rs->search( { 'goal.objective_id' => $c->req->param('type_id') });

	}
	if ( $c->req->param('region_id')) {
		$c->detach unless $c->req->param('region_id') =~ /^\d+$/;

		$rs = $rs->search( { region_id => $c->req->param('region_id') });

	}	
	
	if ( $c->req->param('lnglat')){
		$c->detach unless $c->req->param('lnglat') =~ qr/^(\-?\d+(\.\d+)?)\ \s*(\-?\d+(\.\d+)?)$/;
		my $lnglat = $c->req->param('lnglat');
	    my @teste = $c->model('DB')->resultset('Region')->search_rs(
        
            \[
               	q{ST_Intersects(me.geom::geography, ?::geography )},  
                [ _coords => qq{SRID=4326;POINT($lnglat)} ]
            ],
			{
				select => [ qw/id name/],
				result_class => 'DBIx::Class::ResultClass::HashRefInflator',
			}	
   	    )->all;
			
		$rs = $rs->search( { region_id => $teste[0]->{id} });
	}
	if ($c->req->param('goal_id')) {
		
		$rs = $rs->search( { 'goal.id' => $c->req->param('goal_id') });
	}
    $self->status_ok(
        $c,
        entity => {
            projects => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
						      latitude
							  longitude		
                              /
                        ),
						goal => [
                             (
                                 map {
                                     my $p = $_;
                                     (
                                         map {
                                             { $_ => $p->{goal}->{$_} }
                                           } qw/
                                           name
                                           /
                                       ),
                                 } @{ $r->{goal_projects} },
                             ),
                         ],						
                        url => $c->uri_for_action(
                            $self->action_for('result'),
                            [ $r->{id} ]
                        )->as_string
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

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $project;

    $c->model('DB')->txn_do(
        sub {
            $project = $c->stash->{collection}->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}          = 1;
            $c->req->params->{role}            = 'project';
            $c->req->params->{project_id} = $project->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

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
