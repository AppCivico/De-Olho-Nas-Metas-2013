package SMM::Controller::API::Objective;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::Objective',
    object_key  => 'objective',
    search_ok => {
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

sub base : Chained('/api/base') : PathPart('objectives') : CaptureArgs(0) { }

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

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $objective = $c->stash->{objective};

    $objective->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params       = { %{ $c->req->params } };
    my $objective = $c->stash->{objective};

    $objective->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $objective->id ] )
          ->as_string,
        entity => { id => $objective->id }
      ),
      $c->detach
      if $objective;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;

	my $rs = $c->stash->{collection};
	my $lol = $c->stash->{collection};
	#my $teste = $lol->search( {}, { join => 'goals', select => [qw/me.id me.name/], 'as' => [ 'id', 'name' ], group_by =>  [ 'me.id','me.name' ]});	
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

sub list_POST {
    my ( $self, $c ) = @_;

    my $objective = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $objective->id ] )
          ->as_string,
        entity => {
            id => $objective->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $objective;

    $c->model('DB')->txn_do(
        sub {
            $objective = $c->stash->{collection}->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}          = 1;
            $c->req->params->{role}            = 'objective';
            $c->req->params->{objective_id} = $objective->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $objective->id ] )
          ->as_string,
        entity => {
            id => $objective->id
        }
    );

}

1;
