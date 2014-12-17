package SMM::Controller::API::Region;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::Region',
    object_key  => 'region',
    search_ok => {
        id => 'Int'
    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('regions') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;

    my $region = $c->stash->{region};
	use DDP;
	
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $region->$_, }
                  qw/
                  name
                  address
                  latitude
				  longitude
                  /
            ),
			goal => [
                (
                    map {
                        my $p = $_;
                        (
                            map {
                                { $_ => $p->goal->$_ }
                              } qw/
                              name
                              /
                          ),
                    } $region->goal_regions,
                ),
            ],

        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $region = $c->stash->{organization};

    $region->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params       = { %{ $c->req->params } };
    my $region = $c->stash->{organization};

    $region->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $region->id ] )
          ->as_string,
        entity => { id => $region->id }
      ),
      $c->detach
      if $region;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
	my $rs = $c->stash->{collection};

    $self->status_ok(
        $c,
        entity => {
            regions => [
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

    my $region = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $region->id ] )
          ->as_string,
        entity => {
            id => $region->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $region;

    $c->model('DB')->txn_do(
        sub {
            $region = $c->stash->{collection}->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}          = 1;
            $c->req->params->{role}            = 'region';
            $c->req->params->{region_id} = $region->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $region->id ] )
          ->as_string,
        entity => {
            id => $region->id
        }
    );

}

1;
