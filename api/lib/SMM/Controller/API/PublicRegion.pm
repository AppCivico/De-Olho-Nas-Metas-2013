package SMM::Controller::API::PublicRegion;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Region',
    object_key => 'region',
    search_ok  => {
        id    => 'Int',
        order => 'Str'
    },
    result_attr => {
        prefetch => [ 'projects', 'subprefecture' ]
    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('public/districts') : CaptureArgs(0)
{
    my ( $self, $c ) = @_;
}

#'+select' => [ \q{ST_AsGeoJSON(geom) as geom_json}  ], '+as' => [qw(geom_json)],

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }
my ( $self, $c ) = @_;

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $region = $c->stash->{region};
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $region->$_, }
                  qw/
                  id
                  name
                  lat
                  long
                  geom
                  subprefecture_id
                  /
            ),
            projects => [
                (
                    map {
                        {
                            id        => $_->id,
                            name      => $_->name,
                            latitude  => $_->latitude,
                            longitude => $_->longitude
                        }

                    } $region->projects,
                ),
            ],
            subprefecture => (
                map {
                    {
                        id   => $_->id,
                        name => $_->name,
                    }

                } $region->subprefecture,
            ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $region = $c->stash->{organization};

    $region->delete;

    $self->status_no_content($c);
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
            districts => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              geom
                              name
                              lat
                              long
                              subprefecture_id
                              /
                        ),
                      }
                } $rs->as_hashref->all
            ]
        }
    );
}

1;
