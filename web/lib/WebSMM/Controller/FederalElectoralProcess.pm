package WebSMM::Controller::FederalElectoralProcess;
use Moose;
use namespace::autoclean;
use MIME::Base64;
use URI;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        'categories',
        params => {
            order => 'me.name',
        }
    );
    $c->stash->{select_categories} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{categories} } ];

    $api->stash_result(
        $c,
        'candidates',
        params => {
            order => 'me.name',
        }
    );
    $c->stash->{select_candidates} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{candidates} } ];

    $api->stash_result(
        $c, 'states',
        params => {
            order => 'me.name',
        }
    );
    $c->stash->{select_states} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];
    unshift( $c->stash->{select_states}, [ 'br', 'Brasil' ] );
}

sub index : Chained('base') : PathPart('processos-tse') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        'electoral_regional_courts',
        params => {
            order => 'state.name',
        }
    );
    $c->stash->{select_spe} = [ map { [ $_->{id}, $_->{state}{name} ] }
          @{ $c->stash->{electoral_regional_courts} } ];

    $api->stash_result( $c, 'federal_electoral_processes', );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', ['/root/index'],
            'Ocorreu um erro ao acessar os processos.' );
    }

}

__PACKAGE__->meta->make_immutable;

1;
