package SMM::Controller::API::UserFollowCounsil;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::UserFollowCounsil',
    result_cond => { active => 1 },

    # result_attr => { prefetch => '', ... },
    object_key => 'user_follow_counsil',

    update_roles => [qw/superadmin admin user/],
    create_roles => [qw/superadmin admin/],
    delete_roles => [qw/superadmin admin/],

);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('user_follow_counsil') :
  CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $user  = $c->stash->{user_follow_counsil};
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

    my $user_follow_counsil = $c->stash->{user_follow_counsil};
    use DDP;
    $user_follow_counsil->execute(
        $c,
        for  => 'update',
        with => $c->req->params
    );

    $self->status_accepted(
        $c,
        location => $c->uri_for( $self->action_for('result'),
            [ $user_follow_counsil->id ] )->as_string,
        entity => {
            name => $user_follow_counsil->name,
            id   => $user_follow_counsil->id
        }
      ),
      $c->detach
      if $user_follow_counsil;
}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $user_follow_counsil = $c->stash->{user_follow_counsil};

    use DDP;
    p $user_follow_counsil;
    $self->status_gone( $c, message => 'deleted' ), $c->detach
      unless $user_follow_counsil->active;

    $user_follow_counsil->update( { active => 0 } );

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
            user_follow_counsils => [
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
                              @{ $r->{user_follow_counsil_roles} }
                        ],
                        url => $c->uri_for_action( $self->action_for('result'),
                            [ $r->{id} ] )->as_string
                      }
                  } $c->stash->{collection}->search(
                    $conditions ? {%$conditions} : undef,
                    { prefetch => [ { user_follow_counsil_roles => 'role' } ] }
                  )->as_hashref->all

            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;

    my $user_follow_counsil = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    my $counsil_follow =
      $c->model('DB::UserFollowCounsil')
      ->search(
        { counsil_id => $user_follow_counsil->counsil_id, active => 1 } )
      ->count;

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'),
            [ $user_follow_counsil->id ] )->as_string,
        entity => {
            counsil => {
                id            => $user_follow_counsil->id,
                counsil_count => $counsil_follow
            },
        }
    );

}

sub list_DELETE {
    my ( $self, $c ) = @_;

    my $user_follow_counsil = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'),
            [ $user_follow_counsil->id ] )->as_string,
        entity => {
            id => $user_follow_counsil->id
        }
    );

}
1;
