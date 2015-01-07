package SMM::Controller::API::User;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::User',
    result_cond => { 'me.active' => 1 },

	 result_attr => { 
		prefetch => [{ user_follow_projects =>  'project'} ],
		distinct => 1 
	},
    object_key => 'user',

    update_roles => [qw/superadmin admin user/],
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

    my %attrs = $user->get_inflated_columns;
    $self->status_ok(
        $c,
        entity => {
            roles => [ map { $_->name } $user->roles ],

            ( map { $_ => $attrs{$_}, } qw(id name phone_number username email type) ),

			projects_i_follow => [ map { $_->project_id }  $user->user_follow_projects->search({ active => 1})->all ],
		
			projects => [ 

					map { 
							my $p = $_; 
							map {
								+{ name => $_->name, 
								   id   => $_->id,
								   region => $_->region_id
								 }	
							} $p->project
						} $user->user_follow_projects,
	
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
						}$ufp->project,
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
    if ( $c->req->params->{role} ) {
        $conditions = {
            'role.id' => $c->req->params->{role} == 99
            ? { 'in' => [ 1, 4, 5, 6, 8 ] }
            : $c->req->params
              ->{role} #administrative roles, 99 is just to de    fine the undefined
        };
    }

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
                  } $c->stash->{collection}->search(
                    $conditions ? {%$conditions} : undef,
                    { prefetch => [ { user_roles => 'role' } ] }
                  )->as_hashref->all

            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;
	
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
sub project :Chained('object') :PathPart('project') :Args(1) :ActionClass('REST'){}

sub project_POST{

    my ( $self, $c, $id ) = @_;
	my $user = $c->stash->{user};

	my $user_project = $user->user_follow_projects->search({ project_id => $id })->update({ active => 0});
	use DDP; p $user_project;

	$self->status_accepted(
        $c,
        entity => { id => 1 }
    ),
    $c->detach
    if $user_project;

}

sub user_project_event :Chained('base') :PathPart('user_project_event') :Args(1) :ActionClass('REST'){}

sub user_project_event_GET{

    my ( $self, $c, $id ) = @_;

	my $user = $c->model('DB::User');
	
	my ($result) = $user->search({'me.id' => $id , 'me.active' => 1, 'project_events_read.user_id' => undef },
	{ 
		prefetch => [{ user_follow_projects => { 'project' => { 'project_events' => 'project_events_read' }} }],
		'+columns' => ['project_events.text', 'project_events.id', 'project_events_read.id'],
		distinct => 1,
			
	}
	)->as_hashref->all;	

	$self->status_accepted(
        $c,
        entity =>  $result 
    ),
    if $result;

}

sub user_project_event_all :Chained('base') :PathPart('user_project_event_all') :Args(1) :ActionClass('REST'){}

sub user_project_event_all_GET{

    my ( $self, $c, $id ) = @_;

	my $user = $c->model('DB::User');
	my ($result) = $user->search({'me.id' => $id , 'me.active' => 1 },
	{ 
		prefetch => [{ user_follow_projects => { 'project' => { 'project_events' => 'project_events_read' }} }],
		'select'  => [	\q{to_char(project_events.ts, 'DD/MM/YYYY HH24:MI:SS') }],
		'as'      => ['project_events.process_ts'],
		'+columns' => ['project_events.text', 'project_events.id', 'project_events_read.id'],
		distinct => 1,
			
	}
	)->as_hashref->all;	
	use DDP; p $result;
	$self->status_accepted(
        $c,
        entity =>  $result 
    ),
    if $result;

}

1;
