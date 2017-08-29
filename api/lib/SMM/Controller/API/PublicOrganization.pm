package SMM::Controller::API::PublicOrganization;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::Organization',
    object_key  => 'organization',
    result_attr => {
        prefetch =>
          [ { 'city' => 'state' }, 'subprefecture', 'user_follow_counsils' ]
    },
    search_ok => {
        id => 'Int'
    },

    update_roles =>
      [qw/superadmin user admin webapi organization counsil counsil_master/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/root') : PathPart('public/councils') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $organization = $c->stash->{organization};

    my @campaigns =
      $organization->campaigns->search( undef, { prefetch => 'events' } )->all;

    my $follow_counsil =
      $organization->user_follow_counsils->search( { active => 1 } )->count;

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $organization->$_, }
                  qw/
                  id
                  name
                  address
                  postal_code
                  description
                  phone
                  email
                  website
                  /
            ),
            follow_counsil => $follow_counsil,
            city           => {
                (
                    map { $_ => $organization->city->$_, }
                      qw/
                      id
                      name
                      /
                ),
                state => {
                    (
                        map { $_ => $organization->city->state->$_, }
                          qw/
                          id
                          name
                          /
                    )
                }
            },
            events => [
                map {
                    my $c = $_;
                    map {
                        my $e = $_;
                        (
                            +{

                                id          => $e->id,
                                name        => $e->name,
                                description => $e->description,
                                date        => $e->date->datetime,

                            }
                          )
                      } ( $c->events ),
                  } (@campaigns),

            ],
            campaigns => [
                map {
                    my $e = $_;
                    (
                        +{

                            id          => $e->id,
                            name        => $e->name,
                            description => $e->description,
                            start_in    => $e->start_in->datetime,
                            end_on      => $e->end_on->datetime,
                            address     => $e->address,
                        }
                      )
                  } (@campaigns),

            ],
            subprefecture => (
                map {
                    $_
                      ? (
                        +{
                            id        => $_->id,
                            name      => $_->name,
                            latitude  => $_->latitude,
                            longitude => $_->longitude,
                        }
                      )
                      : ()
                } ( $organization->subprefecture ),
            ),

        }
    );

}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{collection};

    $rs = $rs->search( undef, { order_by => { -asc => [qw/me.name/] } } );
    $self->status_ok(
        $c,
        entity => {
            organizations => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              address
                              postal_code
                              description
                              phone
                              email
                              website
                              complement
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
                } $rs->as_hashref->all
            ]
        }
    );
}

1;
