package SMM::Controller::API::Role;

use Moose;
use JSON::XS;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result => 'DB::Role',

    update_roles => [qw/superadmin admin/],
    create_roles => [qw/superadmin admin/],
    delete_roles => [qw/superadmin admin/],

);

with 'SMM::TraitFor::Controller::DefaultCRUD';
with 'SMM::TraitFor::Controller::AutoBase';
with 'SMM::TraitFor::Controller::Search';

sub base : Chained('/api/base') : PathPart('roles') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $role = $c->stash->{role};

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $role->{$_} }
                  qw/
                  id
                  name
                  /
            ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;

    my $role = $c->stash->{role};

    $role->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $role = $c->stash->{role};

    $role->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $role->id ] )->as_string,
        entity => { id => $role->id }
      ),
      $c->detach
      if $role;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') {
}

sub list_GET {
    my ( $self, $c ) = @_;

    my $rs = $c->stash->{collection};

    if ( $c->req->params->{admin} ) {
        $rs = $rs->search(
            {
                '-or' => [
                    'me.name' => { 'like' => 'operator' },
                    'me.name' => { 'like' => 'admin%' },
                ]
            }
        );
    }

    $rs = $rs->search(
        {
            '-or' => [
                'me.name' => { 'like' => 'user' },
                'me.name' => { 'like' => 'admin%' },
                'me.name' => { 'like' => 'counsil%' },
                'me.name' => { 'like' => 'counsil_master%' },
            ]
        },
        { order_by => [qw/me.name/] }
    );
    $self->status_ok(
        $c,
        entity => {
            roles => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              /
                        ),
                      }
                } $rs->as_hashref->all
            ]
        }
    );

}

sub list_POST {
    my ( $self, $c ) = @_;

    my $params = $c->req->params;

    if ( $params->{add_relation} ) {
        my @roles = decode_json( $params->{roles} );

        eval { $c->model('DB::UserRole')->populate( $roles[0] ); };

        $self->status_gone( $c, message => $@ ) if $@;

        $self->status_ok( $c, entity => { rows => \@roles } );
    }
    else {

        my $role = $c->stash->{collection}
          ->execute( $c, for => 'create', with => $c->req->params );

        $self->status_created(
            $c,
            location =>
              $c->uri_for( $self->action_for('result'), [ $role->id ] )
              ->as_string,
            entity => {
                id => $role->id
            }
        );
    }
}

1;
