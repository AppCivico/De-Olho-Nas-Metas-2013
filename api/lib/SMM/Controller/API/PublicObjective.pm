package SMM::Controller::API::PublicObjective;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Objective',
    object_key => 'objective',
    search_ok  => {
        id => 'Int'
    },

    #result_attr => {
    #    prefetch => [ 'goals' ]
    #},
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/root') : PathPart('public/objectives') :
  CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $objective = $c->stash->{objective};

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $objective->$_, }
                  qw/
                  id
                  name
                  /
            )
        }
    );

}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;

    my $rs = $c->stash->{collection};

    $rs = $rs->search(
        undef,
        {
            order_by => 'name',
        }
    );
    $self->status_ok(
        $c,
        entity => {
            objectives => [
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
                        url => $c->uri_for_action( $self->action_for('result'),
                            [ $r->{id} ] )->as_string
                      }
                } $rs->as_hashref->all
            ]
        }
    );
}

1;
