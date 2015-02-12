package SMM::Controller::API::UserFollowProject;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::UserFollowProject',
    result_cond => { active => 1 },

    # result_attr => { prefetch => '', ... },
    object_key => 'user_follow_project',

    update_roles => [qw/superadmin admin user/],
    create_roles => [qw/superadmin admin/],
    delete_roles => [qw/superadmin admin/],

);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('user_follow_project') :
  CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $user  = $c->stash->{user_follow_project};
    my %attrs = $user->get_inflated_columns;
    $self->status_ok(
        $c,
        entity => {
            roles => [ map { $_->name } $user->roles ],

            map { $_ => $attrs{$_}, }
              qw(id name phone_number username email type)
        }
    );
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $user_follow_project = $c->stash->{user_follow_project};
    use DDP;
    $user_follow_project->execute(
        $c,
        for  => 'update',
        with => $c->req->params
    );

    $self->status_accepted(
        $c,
        location => $c->uri_for( $self->action_for('result'),
            [ $user_follow_project->id ] )->as_string,
        entity => {
            name => $user_follow_project->name,
            id   => $user_follow_project->id
        }
      ),
      $c->detach
      if $user_follow_project;
}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $user_follow_project = $c->stash->{user_follow_project};

    use DDP;
    p $user_follow_project;
    $self->status_gone( $c, message => 'deleted' ), $c->detach
      unless $user_follow_project->active;

    $user_follow_project->update( { active => 0 } );

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
            user_follow_projects => [
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
                        roles => [
                            map { $_->{role}{name} }
                              @{ $r->{user_follow_project_roles} }
                        ],
                        url => $c->uri_for_action( $self->action_for('result'),
                            [ $r->{id} ] )->as_string
                      }
                  } $c->stash->{collection}->search(
                    $conditions ? {%$conditions} : undef,
                    { prefetch => [ { user_follow_project_roles => 'role' } ] }
                  )->as_hashref->all

            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;

    my $user_follow_project = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'),
            [ $user_follow_project->id ] )->as_string,
        entity => {
            id => $user_follow_project->id
        }
    );

}

sub list_DELETE {
    my ( $self, $c ) = @_;

    my $user_follow_project = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'),
            [ $user_follow_project->id ] )->as_string,
        entity => {
            id => $user_follow_project->id
        }
    );

}
1;
