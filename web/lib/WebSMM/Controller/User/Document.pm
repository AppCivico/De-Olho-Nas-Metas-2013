package WebSMM::Controller::User::Document;
use Moose;
use utf8;
use namespace::autoclean;
use Config::General;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/user/base') : PathPart('document') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    $api->stash_result( $c, [ 'documents', $id ], stash => 'document_obj' );

    $c->detach( '/form/not_found', [] ) if $c->stash->{document_obj}{error};
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        ['documents'],
        params => {
            user_id => $c->user->id
        }
    );

    $c->stash->{class_name_conf} = {
        foto_carro             => 'Foto do carro',
        registro_cnh           => 'Registro de cnh',
        comprovante_residencia => 'Comprovante de residência'
    };

}

sub edit : Chained('object') : PathPart('') : Args(0) {
}

sub add : Chained('base') : PathPart('new') : Args(0) {
    my ( $self, $c ) = @_;
}

__PACKAGE__->meta->make_immutable;

1;
