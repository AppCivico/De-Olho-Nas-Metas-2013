package WebSMM::Controller::ForgotPassword;
use Moose;
use namespace::autoclean;
use MIME::Base64;
use URI;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub change : Chained('base') : PathPart('forgot_password/change') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

    $c->stash->{template} = 'auto/change_password.tt';

    $api->stash_result(
        $c, 'users',
        params => {
            email               => $c->req->params->{email},
            reset_password_key  => decode_base64($c->req->params->{key}),
        }
    );

    if(!$c->stash->{users}[0]) {
        $c->stash->{invalid_account} = 1;
        $c->detach();
    }

}

sub forgot_password : Chained('base') : PathPart('forgot_password') : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'auto/forgot_password.tt';
}

__PACKAGE__->meta->make_immutable;

1;
