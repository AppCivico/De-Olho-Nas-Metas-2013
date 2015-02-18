use common::sense;
package WebSMM::Controller::Admin::User;
use Moose;
use namespace::autoclean;
use POSIX;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('user') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');


    #Controlando quais tipos de usuários o usuário corrente consegue controlar(CRUD).
    my $subparams;
    given($c->stash->{role_controller}){
      when('superadmin'){
        $subparams = {
                    'all'        => 1,
                  };
      }
      when('admin') {
        $subparams = {
                    'counsil_master' => 1,
                    'counsil'        => 1,
                  };
      }
      when('consul_master') {
        $subparams = {
                    'counsil'        => 1,
                  };
      }
      default {
        die q[Role not mapped: '] . $c->stash->{role_controller} . q['];
      }
    }


    if(!exists $subparams->{all}){
      $api->stash_result( $c, 'roles', 
                          params => $subparams, 
                      );
    }
    else {
      $api->stash_result( $c, 'roles', );
    }
    
    $c->stash->{users} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{roles} } ];
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'users', $id ], stash => 'user_obj' );
    my %ar = map { $_ => 1 } @{ $c->stash->{user_obj}{role_ids} };
    $c->stash->{active_roles} = \%ar;

    $c->detach( '/form/not_found', [] ) if $c->stash->{user_obj}{error};
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c, 'users',
        params => {
            role => $c->req->params->{role} ? $c->req->params->{role} : 99,
            filters => 1,
            order   => 'me.name'
        }
    );

}

sub edit : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'roles', params => { admin => 1 } );
    my $r = $c->stash->{active_roles};
    $c->stash->{roles} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{roles} } ];
}

sub add : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');
    #$api->stash_result( $c, 'roles', params => { admin => 1,
    #                                            } );
    #delete $c->stash->{roles};   
}

__PACKAGE__->meta->make_immutable;

1;
