package SMM::Controller::API::Project;

use Moose;
use utf8;
use DDP;
use List::Util qw/sum/;
use Math::Round qw/round/;

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
    my @images =
      $project->images_projects->search( undef, { prefetch => 'user' } )->all;
    $type = $_->goal->objective_id for $project->goal_projects;

    my @pap = $project->project_accept_porcentages->search(
        {},
        {
            select   => [ 'progress', \'count(1)' ],
            as       => [qw/progress qtde/],
            group_by => ['progress'],
            result_class => 'DBIx::Class::ResultClass::HashRefInflator',
        }
    )->all;

    my @qtde_total;

    push( @qtde_total, $_->{qtde} ) for @pap;

    my $total = sum(@qtde_total);
    my @pap_total;
    map {
        push @pap_total,
          {
            percentage => round( ( $_->{qtde} / $total ) * 100 ),
            qtde       => $_->{qtde},
            progress   => $_->{progress}
          }
    } @pap;
    my @pap_user = $project->project_accept_porcentages->search(
        {},
        {
            select       => ['user_id'],
            as           => [qw/user/],
            group_by     => ['user_id'],
            result_class => 'DBIx::Class::ResultClass::HashRefInflator',
        }
    )->all;

    my $objective =
      $project->resultset('Objective')->search( { id => $type } )->next;
    my $region;

    ($region) = map {
        {
            id               => $_->id,
            name             => $_->name,
            subprefecture_id => $_->subprefecture_id
        }
      } $project->region
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
                  percentage
                  budget_executed
                  qualitative_progress_1
                  qualitative_progress_2
                  qualitative_progress_3
                  qualitative_progress_4
                  qualitative_progress_5
                  qualitative_progress_6
                  goal_id
                  /
            ),
            goal => {
                map {
                    my $p = $_;
                    p $p;

                    id     => $p->goal->id,
                      name => $p->goal->name

                } ( $project->goal_projects ),
            },
            images => [
                map {
                    my $p = $_;
                    $p
                      ? (
                        +{
                            name_image  => $p->name_image,
                            description => $p->description,
                            user        => $p->user ? $p->user->name : ""
                        }
                      )
                      : ()

                } @images,
            ],

            (
                type => $objective
                ? [
                    {
                        id   => $objective->id,
                        name => $objective->name
                    },

                  ]
                : undef
            ),
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

            statistic      => \@pap_total,
            users_question => \@pap_user,
            comments       => [
                (

                    map {
                        defined $_ && $_->id
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
    my $project = $c->stash->{project};

    $project->search_related('project_prefectures')->delete;
    $project->search_related('project_milestones')->delete;

    $project->search_related('goal_projects')->delete;
    $project->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params  = { %{ $c->req->params } };
    my $project = $c->stash->{project};

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

        $c->detach unless $c->req->param('type_id') =~ /^\d+$/;

        $rs =
          $rs->search( { 'goal.objective_id' => $c->req->param('type_id') } );

    }
    if ( $c->req->param('region_id') ) {
        $c->detach unless $c->req->param('region_id') =~ /^\d+$/;

        $rs = $rs->search( { region_id => $c->req->param('region_id') } );

    }

    $rs = $rs->search(
        {
            -or => [
                { "approved_project_events.is_last" => 1 },
                { "approved_project_events.id"      => undef }
            ]
        }
    );
    if ( $c->req->param('lnglat') ) {
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
                              percentage
                              latitude
                              longitude
                              updated_at
                              /
                        ),
                        goal => {
                            (
                                map {
                                    my $p = $_;
                                    (

                                        map { $_ => $p->{goal}->{$_} } qw/
                                          id
                                          name
                                          /

                                      ),
                                } @{ $r->{goal_projects} },
                            ),
                        },
                        (
                            interation => $r->{approved_project_events}
                            ? do {
                                my $x = $r->{approved_project_events}[0];
                                ( map { $x->{$_} } qw/id/ ),;
                              }
                            : undef
                        ),
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
            '+select' => [ \q{ST_AsGeoJSON(region.geom,6) as geom_json} ],
            '+as'     => [qw(geom_json)],
            columns =>
              [qw( me.id me.latitude me.longitude region.id region.name)],
            collapse => 1,
            join     => [qw(region)]
        }
    )->as_hashref->next;
    $self->status_ok( $c, entity => { geom => $geom } );

}

sub list_geom : Chained('base') PathPart('list_geom') : Args(0) {
    my ( $self, $c ) = @_;

    my @geom = $c->model('DB')->resultset('Project')->search(
        {
            -and => [
                latitude        => { '!=', undef },
                longitude       => { '!=', undef },
                'me.percentage' => { '!=', undef }
            ]
        },
        {
            join => { 'goal_projects' => 'goal' },
            columns => [qw( id name latitude longitude percentage goal.id )],
        }
    )->as_hashref->all;
    $self->status_ok( $c, entity => { geom => \@geom } );

}

sub autocomplete : Chained('base') PathPart('autocomplete') : Args(0) {
    my ( $self, $c ) = @_;

    my @projects = $c->model('DB')->resultset('Project')->search(
        {
            name => {
                ilike => \[
                    q{'%' || ? || '%'},
                    [ _name => $c->req->params->{project_name} ]
                ]
            }
        },
        {
            select => [qw/ id name /],
            as     => [qw( id value)]
        }
    )->as_hashref->all;
    $self->status_ok( $c, entity => { projects => \@projects } );

}
1;
