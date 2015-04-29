package WebSMM::Controller::ForgotPassword;
use Moose;
use utf8;
use DateTime;
use JSON::XS;
use DateTime::Format::Pg;
use namespace::autoclean;
use Digest::MD5 qw{md5_hex};

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->response->headers->header( 'charset' => 'utf-8' );
    $c->stash->{template_wrapper} = 'func';
}

sub forgot_password : Chained('base') : PathPart('forgot-password') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');
    $c->res->redirect( $c->uri_for_action('/user/account/index') ), $c->detach
      if $c->user_exists;

    $c->stash->{template} = 'auto/forgot_password.tt';
    $c->detach unless $c->req->method eq 'POST';

    my $key = md5_hex( time, {}, $$ );

    $api->stash_result(
        $c,
        [ 'user', 'forgot_password', 'email' ],
        method => 'POST',
        params => {
            email => $c->req->params->{email},
            hash  => $key,
        }
    );
    use DDP;
    p $c->stash;
    warn '1';

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    $c->detach(
        '/form/redirect_ok',
        [
            \'/forgot-password', {},
            'Enviado com sucesso!',
            form_ident => $c->req->params->{form_ident}
        ]
    );

}

sub change_password : Chained('base') : PathPart('change-password') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

    $c->res->redirect( $c->uri_for_action('/user/account/index') ), $c->detach
      if $c->user_exists;

    $c->stash->{template} = 'auto/change_password.tt';

    $c->detach unless $c->req->method eq 'POST';
    my $params = { %{ $c->req->params } };

    $api->stash_result(
        $c,
        [ 'user', 'forgot_password', 'reset_password' ],
        method => 'POST',
        params => $params,
    );
    use DDP;
    p $c->stash;
    warn '1';

    $c->stash->{error} = 'Chave expirada.'
      if $c->stash->{form_error}->{hash} eq 'invalid';

    warn $c->stash->{error};
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    warn '2';
    $c->detach(
        '/form/redirect_ok',
        [
            \'/login', {},
            'Nova senha cadastrada com sucesso!',
            form_ident => $c->req->params->{form_ident}
        ]
    );

}

__PACKAGE__->meta->make_immutable;

1;
