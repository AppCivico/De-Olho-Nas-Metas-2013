package SMM::Controller::API::User;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::User',
    result_cond => { active => 1 },

    # result_attr => { prefetch => '', ... },
    object_key => 'user',

    update_roles => [qw/superadmin/],
    create_roles => [qw/superadmin/],
    delete_roles => [qw/superadmin/],

);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('users') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

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

            map { $_ => $attrs{$_}, } qw(id name email type)
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

    $self->status_ok(
        $c,
        entity => {
            users => [
                map {
                    my $r = $_;
                    +{
                        ( map { $_ => $r->{$_} } qw/id name email type/ ),

                        roles =>
                          [ map { $r->{role}{name} } @{ $r->{user_roles} } ],

                        url => $c->uri_for_action( $self->action_for('result'),
                            [ $r->{id} ] )->as_string
                      }
                  } $c->stash->{collection}->search( undef,
                    { prefetch => [ { user_roles => 'role' } ] } )
                  ->as_hashref->all
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

1;
