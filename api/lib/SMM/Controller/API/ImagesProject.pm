package SMM::Controller::API::ImagesProject;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::ImagesProject',
    object_key => 'images_project',
    search_ok  => {
        id => 'Int'
    },
    result_attr => {
        prefetch => [   'projects' 
        ],
    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('images_project') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;
    my $images_project = $c->stash->{images_project};

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $images_project->$_, }
                  qw/
                  id
				  project_id
                  name_image
                  /
            ),
        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $images_project = $c->stash->{organization};

    $images_project->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params  = { %{ $c->req->params } };
    my $images_project = $c->stash->{organization};

    $images_project->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $images_project->id ] )
          ->as_string,
        entity => { id => $images_project->id }
      ),
      $c->detach
      if $images_project;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;

    my $rs = $c->stash->{collection};

    $self->status_ok(
        $c,
        entity => {
            images_projects => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              project_id
                              name_image
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

    my $images_project = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $images_project->id ] )
          ->as_string,
        entity => {
            id => $images_project->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $images_project;

    $c->model('DB')->txn_do(
        sub {
            $images_project = $c->stash->{collection}
              ->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}     = 1;
            $c->req->params->{role}       = 'images_project';
            $c->req->params->{images_project_id} = $images_project->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $images_project->id ] )
          ->as_string,
        entity => {
            id => $images_project->id
        }
    );

}

1;
