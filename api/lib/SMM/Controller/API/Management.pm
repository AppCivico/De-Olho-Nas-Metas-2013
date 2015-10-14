package SMM::Controller::API::Management;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Management',
    object_key => 'management',
    search_ok  => {
        id => 'Int'
    },

    update_roles => [qw/superadmin user admin webapi management/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('managements') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $management = $c->stash->{management};

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $management->$_, }
                  qw/
                  id
                  name
                  start_date
                  expected_end_date
                  active
                  created_at
                  /
            ),
            city => {
                (
                    map { $_ => $management->city->$_, }
                      qw/
                      id
                      name
                      /
                ),
                state => {
                    (
                        map { $_ => $management->city->state->$_, }
                          qw/
                          id
                          name
                          /
                    )
                }
            },
            organization => {
                (
                    map { $_ => $management->organization->$_, }
                      qw/
                      id
                      name
                      /
                ),
            },
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $management = $c->stash->{management};

    $management->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params     = { %{ $c->req->params } };
    my $management = $c->stash->{management};

    $management->execute( $c, for => 'update', with => $params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $management->id ] )
          ->as_string,
        entity => { id => $management->id }
      ),
      $c->detach
      if $management;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;

    $self->status_ok(
        $c,
        entity => {
            managements => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              start_date
                              expected_end_date
                              active
                              created_at
                              /
                        ),
                        city => {
                            (
                                map { $_ => $r->{city}{$_}, }
                                  qw/
                                  id
                                  name
                                  /
                            ),
                            state => {
                                (
                                    map { $_ => $r->{city}{state}{$_}, }
                                      qw/
                                      id
                                      name
                                      /
                                )
                            }
                        },
                        url => $c->uri_for_action(
                            $self->action_for('result'),
                            [ $r->{id} ]
                        )->as_string
                      }
                } $c->stash->{collection}->as_hashref->all
            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;

    my $management = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $management->id ] )
          ->as_string,
        entity => {
            id => $management->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $management;

    $c->model('DB')->txn_do(
        sub {
            $management = $c->stash->{collection}
              ->execute( $c, for => 'create', with => $c->req->params );

            #$c->req->params->{active} 			= 1;
            #$c->req->params->{role} 			= 'management';
            #$c->req->params->{management_id} 	= $management->id;

#my $user = $c->model('DB::User')->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $management->id ] )
          ->as_string,
        entity => {
            id => $management->id
        }
    );

}

1;
