package WebSMM::Controller::PreRegistration;

use Moose;
use DateTime;
use JSON::XS;
use DateTime::Format::Pg;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('pre-cadastro') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->response->headers->header( 'charset' => 'utf-8' );
}

sub cadastro : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    if ( $c->user ) {
        $c->detach( 'Form::Login' => 'after_login' );
    }

    my $api = $c->model('API');

    $api->stash_result( $c, 'states' );
    $c->stash->{select_states} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];

    $api->stash_result( $c, 'zones' );
    $c->stash->{select_zones} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{zones} } ];

    if( $c->stash->{body}{state_id} ) {
        $api->stash_result(
            $c, 'cities',
            params => {
                state_id    => $c->{stash}->{body}{state_id},
                order       => 'name'
            }
        );

        $c->stash->{select_cities} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{cities} } ];
    }

    if ( $c->stash->{body}{birth_date} ) {
        my $now     = DateTime->now;
        my $body    = { %{ $c->stash->{body} } };

        my $form = $c->model('Form');
        $form->format_date( $body, 'birth_date' );

        if ( $body->{birth_date} && $body->{birth_date} ne '--') {
            my $dt          = DateTime::Format::Pg->parse_datetime( $body->{birth_date} );
            my $interval    = $now->subtract_datetime($dt);

            if ( $interval->years < 18 ) {
                $c->stash->{too_young} = 1;
            }
        }
    }

    if($c->req->params->{fb_tab}) {
        $c->stash->{fb_tab} = 1;
    }

    if($c->req->params->{fb_login}) {
        $c->stash->{fb_login} = 1;
    }

    $c->stash->{template} = 'auto/pre_cadastro.tt';
}

sub registration_successfully : Chained('base') : PathPart('registration_successfully') : Args(0) { }

__PACKAGE__->meta->make_immutable;

1;
