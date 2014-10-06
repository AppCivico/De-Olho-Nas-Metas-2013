package WebSMM::Controller::Form::ForgotPassword;
use Moose;
use namespace::autoclean;
use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/form/root') : PathPart('') : CaptureArgs(0) { }

sub forgot_password : Chained('base') : PathPart('forgot_password') : Args(0) {
    my ( $self, $c ) = @_;

    my $api            = $c->model('API');
    my $validation_key = sha1_hex( $c->req->params->{email} );

    $api->stash_result(
        $c, 'users',
        method => 'GET',
        params => {
            email => $c->req->params->{email}
        }
    );

    if ( !$c->stash->{form}{error} && $c->stash->{users}[0]{id} ) {
        $api->stash_result(
            $c,
            [ 'users', $c->stash->{users}[0]{id} ],
            method => 'PUT',
            body   => {
                reset_password_key => $validation_key
            }
        );
    }
    else {
        $c->detach( '/form/redirect_error', [] );
    }

    if ( !$c->stash->{form}{error} ) {
        $api->stash_result(
            $c,
            'reset_password/send_email',
            params => {
                email          => $c->req->params->{email},
                validation_key => $validation_key,
            }
        );

        if ( !$c->stash->{form}{error} ) {
            $c->detach(
                '/form/redirect_ok',
                [
                    '/forgotpassword/forgot_password',
                    {},
                    'E-mail enviado com sucesso. Verifique sua caixa de mensagens!'
                ]
            );
        }
        else {
            $c->detach( '/form/redirect_error', [] );
        }

    }
    else {
        $c->detach( '/form/redirect_error', [] );
    }
}

sub process_change : Chained('base') : PathPart('process_change') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'users', $c->req->params->{user_id} ],
        body => {
            password => $c->req->params->{password}
        }
    );
}

__PACKAGE__->meta->make_immutable;

1;
