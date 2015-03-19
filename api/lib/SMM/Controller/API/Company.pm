package SMM::Controller::API::Company;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result     => 'DB::Company',
    object_key => 'company',
    search_ok  => {
        name_url => 'Str'
    },
    update_roles => [qw/superadmin user admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],
);
with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('companies') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;
    my $company = $c->stash->{company};

    $self->status_ok(
        $c,
        entity => {
            (
                map { $_ => $company->$_, }
                  qw/
                  id
                  name
				  name_url
                  /
            ),

        }
    );

}

sub result_DELETE {
    my ( $self, $c ) = @_;
    my $company = $c->stash->{organization};

    $company->delete;

    $self->status_no_content($c);
}

sub result_PUT {
    my ( $self, $c ) = @_;

    my $params  = { %{ $c->req->params } };
    my $company = $c->stash->{organization};

    $company->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $company->id ] )
          ->as_string,
        entity => { id => $company->id }
      ),
      $c->detach
      if $company;
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{collection};

    $rs = $rs->search(
        undef,
        {
            order_by => 'me.name'
        },
    );

    $self->status_ok(
        $c,
        entity => {
            companies => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              name_url
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

    my $company = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $company->id ] )
          ->as_string,
        entity => {
            id => $company->id
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $project;

    $c->model('DB')->txn_do(
        sub {
            $project = $c->stash->{collection}
              ->execute( $c, for => 'create', with => $c->req->params );

            $c->req->params->{active}     = 1;
            $c->req->params->{role}       = 'project';
            $c->req->params->{project_id} = $project->id;

            my $user = $c->model('DB::User')
              ->execute( $c, for => 'create', with => $c->req->params );
        }
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $project->id ] )
          ->as_string,
        entity => {
            id => $project->id
        }
    );

}

sub geom : Chained('base') PathPart('geom') : Args(0) {
    my ( $self, $c ) = @_;

    my $id = $c->req->param('project_id')
      if $c->req->param('project_id') =~ /^\d+$/;

    my ($geom) = $c->model('DB')->resultset('Project')->search(
        { 'me.id' => $id },
        {
            '+select' => [ \q{ST_AsGeoJSON(region.geom,3) as geom_json} ],
            '+as'     => [qw(geom_json)],
            columns =>
              [qw( me.id me.latitude me.longitude region.id region.name)],
            collapse => 1,
            join     => [qw(region)]
        }
    )->as_hashref->next;
    $self->status_ok( $c, entity => { geom => $geom } );

}

sub list_geom : Chained('base') PathPart('list_geom') : Args(0) {
    my ( $self, $c ) = @_;

    my @geom = $c->model('DB')->resultset('Project')->search(
        {
            -and =>
              [ latitude => { '!=', undef }, longitude => { '!=', undef } ]
        },
        {
            columns => [qw( id name latitude longitude)],
        }
    )->as_hashref->all;
    $self->status_ok( $c, entity => { geom => \@geom } );

}
1;
