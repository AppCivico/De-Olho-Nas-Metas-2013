package SMM::Controller::API::ProjectPublic;

use Moose;
use utf8;
use DDP;
BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Project',
    object_key => 'project',
    search_ok  => {
        id => 'Int'
    },
    result_attr => {
        prefetch => [ { 'goal_projects' => 'goal' }, 'region', ],

    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('public/projects') :
  CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;
    my $project = $c->stash->{project};

    my $type = $_->goal->objective_id for $project->goal_projects;

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
                    p $p;

                    id     => $p->goal->id,
                      name => $p->goal->name

                } ( $project->goal_projects ),
            },

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

        }
    );

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

1;
