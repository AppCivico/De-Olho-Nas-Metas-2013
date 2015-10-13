package WebSMM::Controller::Form::InviteCounsil;
use Moose;
use namespace::autoclean;
use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/form/root') : PathPart('') : CaptureArgs(0) { }

sub invite_counsil : Chained('base') : PathPart('invite_counsil') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        'invite_counsil/email',
        method => 'POST',
        params => {
            email           => $c->req->params->{email},
            organization_id => $c->req->params->{organization_id}
        }
    );
    if ( $c->stash->{error} ) {

        $c->detach( '/form/redirect_error', [] );
    }

    $c->detach(
        '/form/redirect_ok',
        [
            \'/user/perfil/convidar',
            {},
            'Convite enviado com sucesso!',
            form_ident => $c->req->params->{form_ident}
        ]
    );
}

sub contact_admin_council : Chained('base') : PathPart('contact_admin_council')
  : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    $api->stash_result(
        $c,
        'register_counsil_manual/email',
        method => 'POST',
        params => {
            email        => $c->req->params->{name},
            name         => $c->req->params->{email},
            phone_number => $c->req->params->{phone_number},
            council      => $c->req->params->{council},
        }
    );
    if ( $c->stash->{error} ) {

        $c->detach( '/form/redirect_error', [] );
    }

    $c->detach(
        '/form/redirect_ok',
        [
            \'/conselho/contato',
            {},
            'E-mail enviado com sucesso, entraremos em contato em breve!',
            form_ident => $c->req->params->{form_ident}
        ]
    );
}

__PACKAGE__->meta->make_immutable;

1;
