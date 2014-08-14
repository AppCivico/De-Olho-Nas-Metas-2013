package WebSMM::Controller::Form::PreRegistration;
use parent qw/Catalyst::Controller::ActionRole/;
use Moose;
use namespace::autoclean;
use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);
use Digest::SHA qw(hmac_sha256_hex);
use MIME::Base64;
use JSON::XS;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/form/root') : PathPart('') : CaptureArgs(0) { }

sub process : Chained('base') : PathPart('pre-registration') : Args(0) {
    my ( $self, $c ) = @_;

    my $params = { %{ $c->req->params } };

    my $api  = $c->model('API');
    my $form = $c->model('Form');
    my $ceps = ['postal_code_job', 'postal_code_home', 'postal_code_college'];

    $form->only_number( $params, 'mobile_number');
    $form->format_date( $params, 'birth_date');
    $form->only_number($params, @$ceps);

    $api->stash_result(
        $c, 'pre_registrations',
        method => 'POST',
        body   => $params
    );

    if ( !$c->stash->{error} ) {
        $c->detach( '/form/redirect_ok2', [ '/preregistration/registration_successfully', [], {}, 'Cadastrado com sucesso!' ] );
    } else {
        $c->detach( '/form/redirect_error', [] );
    }

}

sub process_fb_auth : Chained('base') : PathPart('fb-auth') : Args(0) {
    my ( $self, $c ) = @_;
    use DDP;
    my $api         = $c->model('API');
    my $api_secret  = '85fc748647d6c6deaa4ee076fb396d6c';

    my $params = { % { $c->req->params } };

    my ( $signed_request, $payload )    = split (/\./, $params->{signed_request});

    my $decoded     = decode_base64($payload);
    my @data        = decode_json($decoded);
    $signed_request = decode_base64($signed_request);

    my $hash_hex    = hmac_sha256_hex($payload, $api_secret);

#     if($signed_request ne $hash_hex) {
#         die 'error. Bad signed JSON signature';
#     }

    $c->res->header( 'content-type', 'application/json;charset=UTF-8' );
    $c->res->body( encode_json(\@data) );
}

__PACKAGE__->meta->make_immutable;

1;
