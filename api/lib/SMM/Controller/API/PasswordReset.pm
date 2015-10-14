package SMM::Controller::API::PasswordReset;

use namespace::autoclean;
use JSON qw(encode_json);
use Moose;

use Data::Printer;

use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/root') : PathPart('user/forgot_password') :
  CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash->{collection} = $c->model('DB::PasswordReset')
      or $self->status_forbidden( $c, message => "access denied" ), $c->detach;
}

sub email : Chained('base') : PathPart('email') : Args(0) : ActionClass('REST')
{
    my ( $self, $c ) = @_;
}

sub email_POST {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };
    $params->{ip} = $c->req->header('x-real-ip') || $c->req->address;
    my $dm =
      $c->stash->{collection}->execute( $c, for => 'email', with => $params );

    $self->status_ok( $c, entity => { message => 'ok' } );
}

sub reset_password : Chained('base') : PathPart('reset_password') : Args(0) :
  ActionClass('REST') {
}

sub reset_password_GET {
    my ( $self, $c ) = @_;
    $self->stastus_ok( $c, entity => { ok => 1 } );
}

sub reset_password_POST {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };

    my $dm = $c->stash->{collection}
      ->execute( $c, for => 'reset_password', with => $params );

#$c->model('Logger')->(
#  'sys', "Tentativa de trocar de senha com chave expirada para e-mail " . $c->req->param('email') . ".", 'update'
#),

# $c->model('Logger')->( 'sys', "Usuário " . $c->req->param('email') . " resetou sua senha.", 'update' );

    $self->status_ok( $c, entity => { message => 'ok' } );

}

1;
