package SMM::Controller::API::RegisterCounsilManual;

use namespace::autoclean;
use JSON qw(encode_json);
use Moose;

use Data::Printer;

use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/base') : PathPart('register_counsil_manual') :
  CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash->{collection} = $c->model('DB::RegisterCounsilManual')
      or $self->status_forbidden( $c, message => "access denied" ), $c->detach;
}

sub email : Chained('base') : PathPart('email') : Args(0) : ActionClass('REST')
{
    my ( $self, $c ) = @_;
}

sub email_POST {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };
    use DDP;
    p $params;
    my $dm = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    # $self->status_bad_request( $c, message => encode_json( $dm->errors ) ),
    #   $c->detach
    #   unless $dm->success;

#my $outcome = eval { $dm->get_outcome_for('user.forgot_password.email') };
# $c->model('Logger')->( 'sys', "E-mail " . $c->req->param('email') . " requisitou troca de senha.", 'update' );

    $self->status_ok( $c, entity => { message => 'ok' } );
}

sub key_check : Chained('base') : PathPart('key_check') : Args(0) :
  ActionClass('REST') {
    my ( $self, $c ) = @_;
}

sub key_check_POST {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };

    use DDP;
    p $params;
    my $dm =
      $c->stash->{collection}->check( for => 'key_check', with => $params );
    my $outcome = $dm->apply;

    $self->status_bad_request( $c, message => encode_json( $dm->errors ) ),
      $c->detach
      unless $dm->success;

#my $outcome = eval { $dm->get_outcome_for('user.forgot_password.email') };
# $c->model('Logger')->( 'sys', "E-mail " . $c->req->param('email') . " requisitou troca de senha.", 'update' );

    $self->status_ok( $c, entity => { message => 'ok' } );
}

# sub contact_admin_council : Chained('base') : PathPart('contact_admin_council') : Args(0) {
# 	my( $self, $c ) = @_;
#
# 	$c->
# }
1;
