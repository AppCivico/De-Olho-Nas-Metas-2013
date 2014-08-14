package WebSMM::Controller::User;
use Moose;
use namespace::autoclean;
use URI;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('user') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    if ( !$c->user || !grep { /^user$/ } $c->user->roles ) {
        $c->detach( '/form/redirect_error', [] );
    }

    my $api  = $c->model('API');
    my $form = $c->model('Form');

    $api->stash_result( $c, [ 'drivers', $c->user->driver->{id} ], stash => 'driver' );

    my $fields = [ 'birth_date', 'cnh_validity', 'first_driver_license' ];

    $form->format_date_to_human( $c->stash->{driver}, @$fields );

    $form->format_cpf_to_human( $c->stash->{driver}, 'cpf' );

    $api->stash_result(
        $c,
        ['vehicles'],
        params => {
            driver_id => $c->user->driver->{id}
        }
    );

    # por enquanto, a pessoa só pode ter um veiculo, logo
    # o primeiro é o atual/ativo/o que importa.
    my $vehicle_id = exists $c->stash->{vehicles}[0] ? $c->stash->{vehicles}[0]{id} : undef;

        $c->detach;

}

__PACKAGE__->meta->make_immutable;

1;
