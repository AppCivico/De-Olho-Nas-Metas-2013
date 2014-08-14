package WebSMM::Plugin::Auth::Credential::User;
use Moose;

use namespace::autoclean;

our $VERSION = '0.01';

sub BUILDARGS {
    my ( $self, $config, $c, $realm ) = @_;

    die "context method 'user_session' not present. " . "Have you loaded Catalyst::Plugin::Session::PerUser ?"
      unless $c->can('user_session');

    return $config;
}

sub BUILD {
    my ($self) = @_;
}

sub authenticate {
    my ( $self, $c, $realm, $auth_info ) = @_;

    my $api = $c->model('API');
    my $res = $api->get_result(
        $c, 'login',
        method => 'POST',
        body   => {
            'email'    => $auth_info->{email},
            'password' => $auth_info->{password},
        }
    );

    if ( $res->{error} ) {
        $c->stash->{error}      = $res->{error};
        $c->stash->{form_error} = $res->{form_error};
        return undef;
    }

    $c->user_session->{user} = $res;

    $auth_info = $res;

    my $user_obj = $realm->find_user( $auth_info, $c );

    return undef unless ref $user_obj;

    return $user_obj;
}

1;
