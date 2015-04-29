package SMM::Controller::API::User;

use Moose;
use DateTimeX::Easy qw(parse);

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::User',
    result_cond => { 'me.active' => 1 },

    result_attr => {
        prefetch => [
            {
                user_follow_projects =>
                  { 'project' => { project_events => 'project_events_read' } }
            },
            'organization',
            'user_follow_counsils'
        ],
        distinct => 1
    },
    object_key => 'user',

    update_roles => [qw/superadmin admin user counsil counsil_master/],
    create_roles => [qw/superadmin admin/],
    delete_roles => [qw/superadmin admin/],

);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('users') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
}

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $user  = $c->stash->{user};
    my $x     = $user->organization;
    my %attrs = $user->get_inflated_columns;

    my @follows_project =
      $user->user_follow_projects->search( { active => 1 } )->all;
    my @follows_council =
      $user->user_follow_counsils->search( { active => 1 } )->all;

    #my @pap   = $user->project_accept_porcentages->all;
    $self->status_ok(
        $c,
        entity => {
            roles => [ map { $_->name } $user->roles ],

            (
                map { $_ => $attrs{$_}, }
                  qw(id name phone_number username email type)
            ),
            (
                organization => $user->organization
                ? {
                    name             => $user->organization->name,
                    id               => $user->organization->id,
                    subprefecture_id => $user->organization->subprefecture_id
                  }
                : undef
            ),
            projects_i_follow => [ map { $_->project_id } @follows_project, ],
            counsils_i_follow => [ map { $_->counsil_id } @follows_council, ],
            projects          => [

                map {
                    my $p = $_;
                    map {
                        +{
                            name   => $_->name,
                            id     => $_->id,
                            region => $_->region_id
                          }
                      } $p->project
                  } @follows_project,

            ],
            councils => [

                map {
                    my $p = $_;
                    map { +{ name => $_->name, id => $_->id, } } $p->counsil
                  } @follows_council,

            ],

            project_event => [
                map {
                    my $ufp = $_;
                    map {
                        my $p = $_;
                        map {

                            +{
                                id         => $_->id,
                                project_id => $_->project_id
                              }

                          } $p->project_events,
                      } $ufp->project,
                } $user->user_follow_projects,
            ],
        }
    );
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $user = $c->stash->{user};
    $user->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $user->id ] )->as_string,
        entity => { name => $user->name, id => $user->id }
      ),
      $c->detach
      if $user;
}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $user = $c->stash->{user};
    $self->status_gone( $c, message => 'deleted' ), $c->detach
      unless $user->active;

    $user->update( { active => 0 } );

    $self->status_no_content($c);
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') {
}

sub list_GET {
    my ( $self, $c ) = @_;
    my $conditions = undef;
    my $rs         = $c->stash->{collection};
    use DDP;
    my $params = { %{ $c->req->params } };
    p $params;
    if ( $c->req->params->{organization} ) {
        $rs =
          $rs->search( { organization_id => $c->req->params->{organization} } );
    }
    if ( $c->req->params->{name} ) {
        $rs = $rs->search(
            {
                'me.name' => {
                    ilike => \[
                        q{'%' || ? || '%' },
                        [ _name => $c->req->params->{name} ]
                    ]
                }
            }
        );
    }
    if ( $c->req->params->{start_in} || $c->req->params->{end_on} ) {

        $c->req->params->{start_in} =~ s/(\d{2})\/(\d{2})\/(\d{4})/$2-$1-$3/
          if $c->req->params->{start_in};
        $c->req->params->{start_in} = parse( $c->req->params->{start_in} )
          if $c->req->params->{start_in};

        $c->req->params->{end_on} =~ s/(\d{2})\/(\d{2})\/(\d{4})/$2-$1-$3/
          if $c->req->params->{end_on};
        $c->req->params->{end_on} = parse( $c->req->params->{end_on} )
          if $c->req->params->{end_on};

        my $dtf      = $rs->result_source->schema->storage->datetime_parser;
        my $begin_ts = $dtf->format_datetime( $c->req->params->{start_in} )
          if $c->req->params->{start_in};
        my $end_ts = $dtf->format_datetime( $c->req->params->{end_on} )
          if $c->req->params->{end_on};
        $rs = $rs->search(
            {
                'me.created_at' => {
                    -between =>
                      [ $begin_ts || '-infinity', $end_ts || 'infinity' ]
                }
            }
        );
    }
    if ( $c->req->params->{role} ) {
        $conditions = {
            'role.id' => $c->req->params->{role} == 99
            ? { 'in' => [ 1, 3, 4, 5, 6, 8, 11, 12 ] }
            : $c->req->params
              ->{role} #administrative roles, 99 is just to de    fine the undefined
        };
    }
    $rs = $rs->search( undef, { order_by => [qw/me.name/] } );
    $self->status_ok(
        $c,
        entity => {
            users => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              email
                              is_active
                              reset_password_key
                              created_at
                              password_defined
                              /
                        ),
                        roles =>
                          [ map { $_->{role}{name} } @{ $r->{user_roles} } ],
                        url => $c->uri_for_action( $self->action_for('result'),
                            [ $r->{id} ] )->as_string
                      }
                  } $rs->search(
                    $conditions ? {%$conditions} : undef,
                    { prefetch => [ { user_roles => 'role' } ] }
                  )->as_hashref->all

            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;
    use DDP;
    p $c->req->params;
    my $user = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $user->id ] )->as_string,
        entity => {
            id => $user->id
        }
    );

}
sub project : Chained('object') : PathPart('project') : Args(1) :
  ActionClass('REST') { }

sub project_POST {

    my ( $self, $c, $id ) = @_;
    my $user = $c->stash->{user};

    my $user_project =
      $user->user_follow_projects->search( { project_id => $id } )
      ->update( { active => 0 } );
    use DDP;
    p $user_project;

    $self->status_accepted( $c, entity => { id => 1 } ), $c->detach
      if $user_project;

}
sub counsil : Chained('object') : PathPart('counsil') : Args(1) :
  ActionClass('REST') { }

sub counsil_POST {

    my ( $self, $c, $id ) = @_;
    my $user = $c->stash->{user};

    my $user_counsil =
      $user->user_follow_counsils->search( { counsil_id => $id } )
      ->update( { active => 0 } );

    my $counsil_count =
      $c->model('DB::UserFollowCounsil')
      ->search( { counsil_id => $id, active => 1 } )->count;
    use DDP;
    p $counsil_count;
    $self->status_accepted( $c, entity => { counsil_count => $counsil_count } );

}

sub user_project_event : Chained('base') : PathPart('user_project_event') :
  Args(1) : ActionClass('REST') { }

sub user_project_event_GET {

    my ( $self, $c, $id ) = @_;

    #my $user = $c->stash->{user};
    my $user = $c->model('DB::User');

    #   my @data = $user->user_follow_projects-search({})

    my ($result) = $user->search(
        {
            'me.id'                       => $id,
            'me.active'                   => 1,
            'user_follow_projects.active' => 1,
            'project_events_read.user_id' => undef,
            'project_events.project_id'   => { '!=' => undef }

        },
        {
            prefetch => [
                {
                    user_follow_projects => {
                        'project' =>
                          { 'project_events' => 'project_events_read' }
                    }
                }
            ],
            '+columns' => [
                'project_events.text', 'project_events.id',
                'project_events_read.id'
            ],
            distinct => 1,

        }
    )->as_hashref->all;

    $self->status_accepted( $c, entity => { notifications => $result } );

}

sub user_project_event_all : Chained('object') :
  PathPart('user_project_event_all') : Args(0) : ActionClass('REST') { }

sub user_project_event_all_GET {

    my ( $self, $c ) = @_;

    my $user = $c->model('DB::User');
    my ($result) = $c->stash->{user}->user_follow_projects->search(
        { 'me.active' => 1 },
        {
            prefetch => [
                {
                    user_follow_projects => {
                        'project' =>
                          { 'project_events' => 'project_events_read' }
                    }
                }
            ],
            'select' =>
              [ \q{to_char(project_events.ts, 'DD/MM/YYYY HH24:MI:SS') } ],
            'as'       => ['project_events.process_ts'],
            '+columns' => [
                'project_events.text', 'project_events.id',
                'project_events_read.id'
            ],
            distinct => 1,

        }
    )->as_hashref->all;
    use DDP;
    p $result;
    $self->status_accepted(
        $c,
        entity => $result,

      ),
      if $result;

}

1;
