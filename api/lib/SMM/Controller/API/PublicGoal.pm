package SMM::Controller::API::PublicGoal;

use Moose;
use utf8;
use List::MoreUtils qw(uniq);

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::Goal',
    object_key  => 'goal',
    result_attr => {
        prefetch => [
            { 'goal_projects' => 'project' }, 'objective', 'goal_porcentages',
        ],
        order_by => 'me.id',

    },

    update_roles => [qw/superadmin user admin webapi/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/root') : PathPart('public/goals') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $goal    = $c->stash->{goal};
    my @budgets = $goal->budgets->all;

    use DDP;
    my @region_ids;
    @region_ids =
      map  { $_->project->region_id }
      grep { $_->project->region_id } $goal->goal_projects;
    my @region_ids_unique = uniq @region_ids;
    my @region;

    if (@region_ids_unique) {

        @region = $goal->resultset('Region')->search(
            {
                id => { '-in' => \@region_ids_unique }
            },

            {
                order_by     => [qw/name/],
                select       => [qw/id name/],
                result_class => 'DBIx::Class::ResultClass::HashRefInflator',
            }
        )->all;
    }
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $goal->$_, }
                  qw/
                  id
                  name
                  description
                  project_count
                  goal_number
                  expected_start_date
                  expected_end_date
                  updated_at
                  expected_budget
                  transversality
                  will_be_delivered
                  qualitative_progress_1
                  qualitative_progress_2
                  qualitative_progress_3
                  qualitative_progress_4
                  qualitative_progress_5
                  qualitative_progress_6
                  /
            ),
            goal_projects => {
                (
                    map {

                        my $d = $_;
                        (
                            map { $_ => $d->$_ }
                              qw/
                              id
                              /
                          ),

                      } $goal->goal_projects,

                ),
            },
            objective => {
                (
                    map {

                        my $d = $_;
                        (
                            map { $_ => $d->$_ }
                              qw/
                              id
                              name
                              /
                          ),

                      } $goal->objective,

                ),
            },
            project => [
                (
                    map {
                        my $p = $_;
                        (
                            +{
                                map { $_ => $p->project->$_ }
                                  qw/
                                  id
                                  name
                                  latitude
                                  longitude
                                  region_id
                                  /
                            }
                          ),
                    } $goal->goal_projects,
                ),
            ],
            budgets => [
                (
                    map {
                        my $p = $_;
                        (
                            +{
                                map { $_ => $p->$_ }
                                  qw/
                                  id
                                  business_name
                                  business_name_url
                                  cnpj
                                  dedicated_value
                                  liquidated_value
                                  observation
                                  dedicated_year
                                  organ_code
                                  organ_name
                                  /
                            }
                          ),
                    } @budgets,
                ),
            ],

            project_qt => [
                (
                    map {
                        my $p = $_;
                        (
                            +{
                                map { $_ => $p->project->$_, }
                                  qw/
                                  id
                                  name
                                  /
                            },
                          ),
                    } $goal->goal_projects,
                ),
            ],

            region      => \@region,
            percentages => (
                map {
                    +{
                        owned     => $_->owned,
                        remainder => $_->remainder,
                      }

                  } $goal->goal_porcentages,

            ),
        }
    );

}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;

    my $rs = $c->stash->{collection};

    if ( $c->req->param('type_id') ) {
        $c->detach('/rest_error') unless $c->req->param('type_id') =~ qr/^\d+$/;

        $rs = $rs->search( { objective_id => $c->req->param('type_id') } );
    }
    if ( $c->req->param('region_id') ) {
        $self->status_bad_request(
            $c, message => "Parâmetro região inválido.",
          ),
          $c->detach
          unless $c->req->param('region_id') =~ qr/^\d+$/;

        $rs =
          $rs->search( { 'project.region_id' => $c->req->param('region_id') } );
        unless ($rs) {
            $self->status_bad_request(
                $c, message => "Nenhuma meta encontrada",
              ),
              $c->detach;
        }
    }
    if ( $c->req->param('lnglat') ) {
        $c->detach
          unless $c->req->param('lnglat') =~
          qr/^(\-?\d+(\.\d+)?)\ \s*(\-?\d+(\.\d+)?)$/;
        my $lnglat = $c->req->param('lnglat');

        my $region = $c->model('DB')->resultset('Region')->search_rs(

            \[
                q{ST_Intersects(me.geom::geography, ?::geography )},
                [ _coords => qq{SRID=4326;POINT($lnglat)} ]
            ],
            {
                select       => [qw/id/],
                result_class => 'DBIx::Class::ResultClass::HashRefInflator',
            }
        )->single;

        $self->status_bad_request(
            $c, message => "NENHUMA META PRÓXIMA A LOCALIDADE",
          ),
          $c->detach
          unless $region;
        $rs = $rs->search( { 'project.region_id' => $region->{id} } );
    }
    use DDP;

    $self->status_ok(
        $c,
        entity => {
            goals => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              description
                              project_count
                              goal_number
                              expected_start_date
                              expected_end_date
                              updated_at
                              expected_budget
                              transversality
                              will_be_delivered
                              qualitative_progress_1
                              qualitative_progress_2
                              qualitative_progress_3
                              qualitative_progress_4
                              qualitative_progress_5
                              qualitative_progress_6
                              /
                        ),
                        percentage => {
                            (
                                map {

                                    my $d = $_;
                                    (
                                        map { $_ => $d->[0]{$_} }
                                          qw/
                                          owned
                                          /
                                      ),

                                  } $r->{goal_porcentages},

                            ),
                        },

                        url => $c->uri_for_action( $self->action_for('result'),
                            [ $r->{id} ] )->as_string
                      }
                  } $rs->search(
                    undef,
                    {
                        '+select' => [
                            \'(select count(distinct p.region_id) from goal_project gp join project p on p.id = gp.project_id where gp.goal_id = me.id)',
                            \'(select count(distinct gp.project_id) from goal_project gp where gp.goal_id = me.id)'
                        ],
                        '+as' => [ 'region_count', 'project_count' ],
                    }
                  )->as_hashref->all
            ]
        }
    );
}

1;
