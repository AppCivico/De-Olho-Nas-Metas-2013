package SMM::Controller::API::PublicSubprefecture;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Subprefecture',
    object_key => 'subprefecture',
    search_ok  => {
        id    => 'Int',
        order => 'Str'
    },
    result_attr => {
        prefetch => [ 'regions', 'organizations' ]
    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/root') : PathPart('public/subprefectures') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $subprefecture = $c->stash->{subprefecture};
    my $name          = $subprefecture->organizations->get_column('name');

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $subprefecture->$_, }
                  qw/
                  id
                  name
                  acronym
                  site
                  deputy_mayor
                  address
                  telephone
                  /
            ),
            regions => [
                (
                    map {
                        {
                            id   => $_->id,
                            name => $_->name,
                        }

                    } $subprefecture->regions,
                ),
            ],
            organization => (
                map {
                    {
                        id   => $_->id,
                        name => $_->name,
                    }

                } $subprefecture->organizations,
            ),

        }
    );

}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{collection};

    if ( $c->req->param('lnglat') ) {
        $c->detach
          unless $c->req->param('lnglat') =~
          qr/^(\-?\d+(\.\d+)?)\ \s*(\-?\d+(\.\d+)?)$/;
        my $lnglat = $c->req->param('lnglat');
        p $lnglat;
        $rs->search_rs(

            \[
                q{ST_Intersects(me.geom::geography, ?::geography )},
                [ _coords => qq{SRID=4326;POINT($lnglat)} ]
            ],
            {
                select       => [qw/id name/],
                result_class => 'DBIx::Class::ResultClass::HashRefInflator',
            }
        );
    }

    $rs = $rs->search(
        undef,
        {
            order_by => 'me.name'
        },
    );
    $self->status_ok(
        $c,
        entity => {
            subprefectures => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              latitude
                              longitude
                              acronym
                              site
                              email
                              telephone
                              address
                              deputy_mayor
                              /
                        ),
                      }
                } $rs->as_hashref->all
            ]
        }
    );
}

1;
