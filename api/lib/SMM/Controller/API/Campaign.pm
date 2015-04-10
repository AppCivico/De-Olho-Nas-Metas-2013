package SMM::Controller::API::Campaign;

use Moose;
use utf8;
use DateTime;
use DDP;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Campaign',
    object_key => 'campaigns',
    search_ok  => {
        'me.id' => 'Int'
    },
    result_attr => {
        prefetch  => [ 'events', 'organization' ],
        '+select' => [
            \q{to_char(events.date, 'DD/MM/YYYY HH24:MI:SS')},
            \q{to_char(start_in, 'DD/MM/YYYY HH24:MI:SS')},
            \q{to_char(end_on, 'DD/MM/YYYY HH24:MI:SS')},
        ],
        '+as' => [ 'events.date_fmt', 'start_in_fmt', 'end_on_fmt' ],

    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('campaigns') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;
    my $campaigns = $c->stash->{campaigns};
    $self->status_ok(
        $c,
        entity => {
            (
                map {
                        $_ => ref $campaigns->$_ eq 'DateTime'
                      ? $campaigns->$_->datetime
                      : $campaigns->$_
                  } qw/
                  id
                  name
                  description
                  created_at
                  start_in
                  end_on
                  user_id
                  /
            ),
            events => [
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
                } ( $campaigns->events ),
            ],
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $campaigns = $c->stash->{organization};

    $campaigns->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params    = { %{ $c->req->params } };
    my $campaigns = $c->stash->{organization};

    $campaigns->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $campaigns->id ] )
          ->as_string,
        entity => { id => $campaigns->id }
      ),
      $c->detach
      if $campaigns;
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

        my $region = $c->model('DB')->resultset('Region')->search_rs(

            \[
                q{ST_Intersects(me.geom::geography, ?::geography )},
                [ _coords => qq{SRID=4326;POINT($lnglat)} ]
            ],
            {
                select       => [qw/id/],
                result_class => 'DBIx::Class::ResultClass::HashRefInflator',
            }
        )->single;
        $self->status_bad_request(
            $c, message => "NENHUMA CAMPANHA PRÓXIMA A LOCALIDADE",
          ),
          $c->detach
          unless $region;
        $rs = $rs->search( { 'region_id' => $region->{id} } );
    }
    if ( $c->req->param('district_id') ) {
        $rs =
          $rs->search( { 'me.region_id' => $c->req->param('district_id') } );
    }
    if ( $c->req->param('user_id') ) {
        $rs = $rs->search( { 'me.user_id' => $c->req->param('user_id') } );
    }
    use DDP;
    $self->status_ok(
        $c,
        entity => {
            campaigns => [
                map {
                    my $r = $_;

                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              description
                              start_in
                              end_on
                              created_at
                              user_id
                              /
                        ),
                        events => [
                            map {
                                my $e = $_;
                                ( +{ map { $_ => $e->{$_} } qw/id/ } )
                            } @{ $r->{events} },
                        ],
                        organizations => {
                            id   => $r->{organization}->{id},
                            name => $r->{organization}->{name}
                        },
                      }
                } $rs->as_hashref->all
            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;

    if (    defined $c->req->params->{latitude}
        and defined $c->req->params->{longitude} )
    {
        $c->req->params->{longitude} =~ s/ //g;
        $c->req->params->{latitude} =~ s/ //g;
        my $lnglat =
          $c->req->params->{longitude} . ' ' . $c->req->params->{latitude};
        my $region = $c->model('DB')->resultset('Region')->search_rs(

            \[
                q{ST_Intersects(me.geom::geography, ?::geography )},
                [ _coords => qq{SRID=4326;POINT($lnglat)} ]
            ],
            {
                select       => [qw/id/],
                result_class => 'DBIx::Class::ResultClass::HashRefInflator',
            }
        )->next;
        use DDP;
        p $region;
        $c->req->params->{region_id} = $region->{id} if $region;
    }
    my $campaigns = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $campaigns->id ] )
          ->as_string,
        entity => {
            id => $campaigns->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $campaigns;

    $c->model('DB')->txn_do(
        sub {
            $campaigns = $c->stash->{collection}
              ->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}       = 1;
            $c->req->params->{role}         = 'campaigns';
            $c->req->params->{campaigns_id} = $campaigns->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $campaigns->id ] )
          ->as_string,
        entity => {
            id => $campaigns->id
        }
    );

}

1;
