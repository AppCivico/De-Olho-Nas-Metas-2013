package SMM::Controller::API::Project;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Project',
    object_key => 'project',
    search_ok  => {
        id => 'Int'
    },
    result_attr => {
        prefetch => [
            { 'goal_projects' => 'goal' }, 'region',
            'approved_comments', 'user_follow_projects',
            { 'approved_project_events' => 'user' }
        ],

        '+select' => [
            \q{to_char(approved_project_events.ts, 'DD/MM/YYYY HH24:MI:SS')},
            \q{to_char(approved_comments.timestamp, 'DD/MM/YYYY HH24:MI:SS')},
        ],
        '+as' => [
            'approved_project_events.process_ts_fmt',
            'approved_comments.process_ts_fmt'
        ],

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

    my $follow_project =
      $project->user_follow_projects->search( { active => 1 } )->count;
    my $type;
    $type = $_->goal->objective_id for $project->goal_projects;

    my $objective =
      $project->resultset('Objective')->search( { id => $type } )->next;
    my $region;

    ($region) = map { { id => $_->id, name => $_->name } } $project->region
      if $project->region;

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $project->$_, }
                  qw/
                  id
                  name
                  address
                  latitude
                  longitude
				  project_number
				  qualitative_progress_1
				  qualitative_progress_2
				  qualitative_progress_3
				  qualitative_progress_4
				  qualitative_progress_5
				  qualitative_progress_6
                  /
            ),
            goal => {
                map {
                    my $p = $_;
                   		 
                        
                            id   => $p->goal->id,
                            name => $p->goal->name
                        
                      
                } ( $project->goal_projects ),
            },

            type => [
                {
                    id   => $objective->id,
                    name => $objective->name
                },
            ],
            region => $region,

            follow_project => $follow_project,

            project_event => [
                (

                    map {
                        $_
                          ? (
                            +{
                                id         => $_->id,
                                text       => $_->text,
                                name       => $_->user->name,
                                process_ts => $_->get_column('process_ts_fmt'),
                                id_user    => $_->user->id
                            }
                          )
                          : ()
                    } ( $project->approved_project_events ),
                )
            ],
            comments => [
                (

                    map {
                        $_
                          ? (
                            +{
                                id          => $_->id,
                                description => $_->description,
                                name        => $_->user->name,
                                process_ts  => $_->get_column('process_ts_fmt'),
                                user_id     => $_->user->id
                            }
                          )
                          : ()
                    } ( $project->approved_comments ),
                )
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

    my $params  = { %{ $c->req->params } };
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

    if ( $c->req->param('type_id') ) {
		warn "type"; 
        $c->detach unless $c->req->param('type_id') =~ /^\d+$/;

        $rs =
          $rs->search( { 'goal.objective_id' => $c->req->param('type_id') } );

    }
    if ( $c->req->param('region_id') ) {
		warn "region";
        $c->detach unless $c->req->param('region_id') =~ /^\d+$/;

        $rs = $rs->search( { region_id => $c->req->param('region_id') } );
		use DDP; p $rs;

    }

    if ( $c->req->param('lnglat') ) {	
		warn ("lnglat");
        $c->detach
          unless $c->req->param('lnglat') =~
          qr/^(\-?\d+(\.\d+)?)\ \s*(\-?\d+(\.\d+)?)$/;
        my $lnglat = $c->req->param('lnglat');
        my @teste  = $c->model('DB')->resultset('Region')->search_rs(

            \[
                q{ST_Intersects(me.geom::geography, ?::geography )},
                [ _coords => qq{SRID=4326;POINT($lnglat)} ]
            ],
            {
                select       => [qw/id name/],
                result_class => 'DBIx::Class::ResultClass::HashRefInflator',
            }
        )->all;

        unless (@teste) {
            $self->status_bad_request(
                $c, message => "NENHUM PROJETO PRÓXIMO A ESSA LOCALIDADE",
              ),
              $c->detach;
        }
        $rs = $rs->search( { region_id => $teste[0]->{id} } );
    }
    if ( $c->req->param('goal_id') ) {

        $rs = $rs->search( { 'goal.id' => $c->req->param('goal_id') } );
    }
    $rs = $rs->search(
        undef,
        {
            order_by => 'me.name'
        },
    );
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
            $project = $c->stash->{collection}
              ->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}     = 1;
            $c->req->params->{role}       = 'project';
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

sub geom : Chained('base') PathPart('geom') : Args(0) {
    my ( $self, $c ) = @_;

    my $id = $c->req->param('project_id')
      if $c->req->param('project_id') =~ /^\d+$/;

    my ($geom) = $c->model('DB')->resultset('Project')->search(
        { 'me.id' => $id },
        {
            '+select' => [ \q{ST_AsGeoJSON(region.geom,3) as geom_json} ],
            '+as'     => [qw(geom_json)],
            columns   => [qw( me.id me.latitude me.longitude region.id region.name)],
            collapse  => 1,
            join      => [qw(region)]
        }
    )->as_hashref->next;
    $self->status_ok( $c, entity => { geom => $geom } );

}

1;
