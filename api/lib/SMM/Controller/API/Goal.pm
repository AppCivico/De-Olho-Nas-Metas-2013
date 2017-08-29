package SMM::Controller::API::Goal;

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
            { 'goal_projects' => 'project' }, 'objective',
            'approved_comments', 'goal_porcentages',
        ],
        '+select' => [
            \q{to_char(approved_comments.timestamp, 'DD/MM/YYYY HH24:MI:SS')},
        ],
        '+as'    => ['approved_comments.process_ts_fmt'],
        order_by => 'me.id',

    },

    update_roles => [qw/superadmin user admin webapi/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('goals') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $goal                  = $c->stash->{goal};
    my @budgets               = $goal->budgets->all;
    my @progress_goal_counsil = $goal->progress_goal_counsils->search(
        undef,
        {
            created_at => { '<', 'now()' },
            rows       => 1,
            order_by => { -desc => 'created_at' }
        }
    )->next;

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
                  expected_budget
                  goal_number
                  qualitative_progress_1
                  qualitative_progress_2
                  qualitative_progress_3
                  qualitative_progress_4
                  qualitative_progress_5
                  qualitative_progress_6
                  objective_id
                  technically
                  will_be_delivered
                  percentage
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
            objective => $goal->objective
            ? {
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
              }
            : (),
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
            progress_goal_counsil => [
                (

                    map {
                        my $p = $_;
                        $p
                          ? (
                            +{
                                map { $_ => $p->$_ }
                                  qw/
                                  owned
                                  remainder
                                  /
                            }
                          )
                          : ()
                    } @progress_goal_counsil,
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

            region           => \@region,
            goal_porcentages => (
                map {
                    +{
                        owned     => $_->owned,
                        remainder => $_->remainder,
                      }

                  } $goal->goal_porcentages,

            ),
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
                    } ( $goal->approved_comments ),
                )
            ],
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $goal = $c->stash->{goal};

    $goal->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };
    my $goal   = $c->stash->{goal};

    $goal->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $goal->id ] )->as_string,
        entity => { id => $goal->id }
      ),
      $c->detach
      if $goal;
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
                              technically
                              will_be_deliveredi
                              expected_start_date
                              expected_end_date
                              percentage
                              goal_number
                              qualitative_progress_1
                              qualitative_progress_2
                              qualitative_progress_3
                              qualitative_progress_4
                              qualitative_progress_5
                              qualitative_progress_6
                              region_count
                              project_count
                              /
                        ),
                        goal_projects => {
                            (
                                map {

                                    my $d = $_;
                                    (
                                        map { $_ => $d->{$_} }
                                          qw/
                                          id
                                          /
                                      ),

                                  } @{ $r->{goal_projects} },

                            ),
                        },
                        url => $c->uri_for_action(
                            $self->action_for('result'),
                            [ $r->{id} ]
                        )->as_string
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

sub list_POST {
    my ( $self, $c ) = @_;

    my $goal = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $goal->id ] )->as_string,
        entity => {
            id => $goal->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $goal;

    $c->model('DB')->txn_do(
        sub {
#$goal = $c->stash->{collection}->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}  = 1;
            $c->req->params->{role}    = 'goal';
            $c->req->params->{goal_id} = $goal->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $goal->id ] )->as_string,
        entity => {
            id => $goal->id
        }
    );

}

sub names : Chained('base') : PathPart('names') : Args(0) {
    my ( $self, $c ) = @_;

    my $goal;

    $c->model('DB')->txn_do(
        sub {
            my @goal =
              $c->model('DB::Goal')
              ->search( undef, { select => qw/id name/, as => qw/name/ } );
        }
    );
    $self->status_ok(
        $c,
        entity => {
            goals => [
                map {
                    my $r = $_;
                    (
                        map { $_ => $r->{$_} }
                          qw/
                          id
                          name
                          /
                      ),
                  } $c->model('DB::Goal')
                  ->search( undef,
                    { select => qw/id name/, as => qw/id name/ } )
                  ->as_hashref->all
            ],
        }
      )

}
1;
