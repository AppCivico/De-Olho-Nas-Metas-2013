package SMM::Controller::API::Subprefecture;

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

sub base : Chained('/api/base') : PathPart('subprefectures') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }
my ( $self, $c ) = @_;

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

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

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $subprefecture = $c->stash->{subprefecture};

    $subprefecture->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params        = { %{ $c->req->params } };
    my $subprefecture = $c->stash->{subprefecture};

    $subprefecture->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $subprefecture->id ] )
          ->as_string,
        entity => { id => $subprefecture->id }
      ),
      $c->detach
      if $subprefecture;
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

    my $subprefecture = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $subprefecture->id ] )
          ->as_string,
        entity => {
            id => $subprefecture->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $subprefecture;

    $c->model('DB')->txn_do(
        sub {
            $subprefecture = $c->stash->{collection}
              ->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}           = 1;
            $c->req->params->{role}             = 'subprefecture';
            $c->req->params->{subprefecture_id} = $subprefecture->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $subprefecture->id ] )
          ->as_string,
        entity => {
            id => $subprefecture->id
        }
    );

}

sub geom : Chained('base') : PathPart('geom') Args(0) {
    my ( $self, $c ) = @_;

    my $id = $c->req->param('subprefecture_id')
      if $c->req->param('subprefecture_id') =~ /^\d+$/;

    my ($geom) = $c->model('DB')->resultset('Subprefecture')->search(
        { 'me.id' => $id },
        {
            '+select' => [ \q{ST_AsGeoJSON(regions.geom,3) as geom_json} ],
            '+as'     => [qw(regions.geom_json)],
            columns =>
              [qw( me.id me.latitude me.longitude regions.id regions.name)],
            collapse => 1,
            join     => [qw(regions)]
        }
    )->as_hashref->all;
    $self->status_ok( $c, entity => { geom => $geom } );
}
1;
