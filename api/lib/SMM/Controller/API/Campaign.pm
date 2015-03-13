package SMM::Controller::API::Campaign;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Campaign',
    object_key => 'campaigns',
    search_ok  => {
        'me.id' => 'Int'
    },
    result_attr => {
        prefetch => ['events'],
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

	use DDP; p $campaigns;
    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $campaigns->$_."", }
                  qw/
			 	  name
				  description
				  created_at
				  start_in
				  end_on
				  user_id
                  /
            ),
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

    use DDP;
    p $rs->as_hashref->all;
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
                                p $e;
                                ( +{ map { $_ => $e->{$_} } qw/id/ } )
                            } @{ $r->{events} },
                        ],
                      }
                } $rs->as_hashref->all
            ]
        }
    );
}

sub list_POST {
    my ( $self, $c ) = @_;

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
