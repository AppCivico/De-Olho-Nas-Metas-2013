package WebSMM::Controller::Cadastro;
use Moose;
use DateTime;
use JSON::XS;
use DateTime::Format::Pg;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->response->headers->header( 'charset' => 'utf-8' );
}

sub cadastro : Chained('base') : PathPart('cadastro') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

    if ( $c->user ) {
        $c->detach( 'Form::Login' => 'after_login' );
    }

    if($c->req->params->{pre_id}) {
        $api->stash_result(
            $c, ['pre_registrations', $c->req->params->{pre_id}],
            stash => 'pre_registrations'
        );
    }

    $api->stash_result( $c, 'states' );
    $c->stash->{select_states} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];

    if( $c->stash->{body}{state_id} && !$c->stash->{body}{postal_code}) {
        $api->stash_result(
            $c, 'cities',
            params => {
                state_id    => $c->{stash}->{body}{state_id},
                order       => 'name'
            }
        );

        $c->stash->{select_cities} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{cities} } ];
    }

    if ( exists( $c->stash->{form_error}{birth_date} ) ) {
        my $now = DateTime->now;

        my $body = { %{ $c->stash->{body} } };

        my $form = $c->model('Form');

        $form->format_date( $body, 'birth_date' );

        #TODO  limpar a string com uma regex retirando os caracteres que vem com a mascara de data
        if ( $body->{birth_date} != '--' ) {
            my $dt = DateTime::Format::Pg->parse_datetime( $body->{birth_date} );

            my $interval = $now->subtract_datetime($dt);

            if ( $interval->years < 18 ) {
                $c->stash->{too_young} = 1;
            }
        }
    }

    $c->stash->{template} = 'auto/cadastro.tt';
}

sub get_address : Chained('base') : PathPart('get_address') {
    my ( $self, $c ) = @_;

    my $api  = $c->model('API');
    my $form = $c->model('Form');

    my $params = { %{ $c->req->params } };

    $form->only_number( $params, 'postal_code' );

    my $result = $api->get_result( $c, ['cep'], params => $params );

    $c->res->header( 'content-type', 'application/json;charset=UTF-8' );
    $c->res->body( encode_json($result) );
}

sub get_cities : Chained('base') : PathPart('get_cities') {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c, 'cities',
    );
     $c->stash(
         select_cities   => [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{cities} } ],
         without_wrapper => 1,
         template        => 'auto/cities.tt'
     );
}

sub get_vehicle_models : Chained('base') : PathPart('get_vehicle_models') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        'vehicle_models',
        params => {
            vehicle_brand_id => $c->req->params->{vehicle_brand_id},
            order            => 'name'
        }
    );

    $c->stash(
        select_vehicle_models => [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{vehicle_models} } ],
        without_wrapper       => 1,
        template => 'user/vehicle/vehicle_models.tt'
    );
}

sub registration_successfully : Chained('base') : PathPart('registration_successfully') : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash( template => 'user/account/success.tt' );
}

__PACKAGE__->meta->make_immutable;

1;
