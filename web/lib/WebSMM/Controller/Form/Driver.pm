package WebSMM::Controller::Form::Driver;
use Moose;
use namespace::autoclean;
use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/form/root') : PathPart('') : CaptureArgs(0) {
}

sub process : Chained('base') : PathPart('driver') : Args(0) {
    my ( $self, $c ) = @_;

    my $param = { %{ $c->req->params } };

    my $api  = $c->model('API');
    my $form = $c->model('Form');

    $form->format_date( $param, 'first_driver_license', 'cnh_validity', 'birth_date' );

    $form->only_number( $param, 'telephone_number', 'mobile_number', 'postal_code', 'cpf' );

    $param->{validation_key} = sha1_hex( $param->{email} . $param->{name} );
    $param->{password}       = $param->{validation_key};

    $api->stash_result(
        $c, 'drivers',
        method => 'POST',
        stash  => 'driver',
        body   => $param
    );

    if ( !$c->stash->{driver}{error} ) {

        my $address = {
            'address'      => $param->{address},
            'number'       => $param->{number},
            'neighborhood' => $param->{neighborhood},
            'postal_code'  => $param->{postal_code},
            'complement'   => $param->{complement},
            user_id        => $c->stash->{driver}{user_id},
            city_id        => $param->{city_id}
        };

        $api->stash_result(
            $c, 'addresses',
            method => 'POST',
            stash  => 'address',
            body   => $address
        );

        if ( !$c->stash->{error} ) {
            $api->stash_result(
                $c, ['drivers', $c->stash->{driver}{id}],
                method => 'PUT',
                body   => {
                    address_id => $c->stash->{address}{id}
                }
            );

            my $route_type = {
                'name'             => 'Casa',
                address_id         => $c->stash->{address}{id},
            };

            $api->stash_result(
                $c, 'vehicle_route_types',
                method => 'POST',
                stash  => 'vehicle_route_type',
                body   => $route_type
            );

            $c->detach('/cadastro/registration_successfully');
        }

    }
    else {
        $c->stash->{error}      = $c->stash->{driver}{error};
        $c->stash->{form_error} = $c->stash->{driver}{form_error};

        $c->detach( '/form/redirect_error', [] );
    }

}

sub process_password : Chained('base') : PathPart('driver/process_password') : Args(1) {
    my ( $self, $c, $user_id ) = @_;

    my $api = $c->model('API');

    my $params = $c->req->params;

    $api->stash_result(
        $c,
        [ 'users', $user_id ],
        stash  => 'user_pass',
        method => 'PUT',
        body   => {
            'password'         => $params->{password},
            'password_confirm' => $params->{confirm_password},
            'active'           => 1
        }
    );
    $params->{email} = $c->stash->{user_pass}{email};

    if ( $c->stash->{user_pass}{error} ) {
        $c->stash->{error}      = $c->stash->{user_pass}{error};
        $c->stash->{form_error} = $c->stash->{user_pass}{form_error};

        $c->detach( '/form/redirect_error', [] );
    }

    $c->forward( '/form/login/login', $params );
}

__PACKAGE__->meta->make_immutable;

1;
