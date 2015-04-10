package WebSMM::Controller::Form;
use Moose;
use URI;
use utf8;
use URI::QueryParam;
use JSON;

use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub root : Chained('/root') : PathPart('form') : CaptureArgs(0) {
}

sub redirect_ok : Private {
    my ( $self, $c, $path, $params, $msg, %args ) = @_;

    my $method = ref $path eq 'SCALAR' ? 'uri_for' : 'uri_for_action';
    $path = ref $path eq 'SCALAR' ? $$path : $path;
    my $a = $c->$method(
        $path,

        #( $method eq 'uri_for_action' ? ( $c->req->captures ) : () ),
        {
            ( ref $params eq 'HASH' ? %$params : () ),
            mid => $c->set_status_msg(
                {
                    %args, status_msg => $msg
                }
            )
        }
    );
    die "uri not found" unless $a;

    $c->res->redirect($a);

}

sub redirect_ok2 : Private {
    my ( $self, $c, $path, $cap, $params, $msg, %args ) = @_;

    my $a = $c->uri_for_action(
        $path, $cap,
        {
            ( ref $params eq 'HASH' ? %$params : () ),
            mid => $c->set_status_msg(
                {
                    %args, status_msg => $msg
                }
            )
        }
    );
    die "uri not found" unless $a;

    $c->res->redirect($a);

}

sub not_found : Private {
    my ( $self, $c ) = @_;

    $c->stash->{template} = 'not_found.tt';
}

sub redirect_error : Private {
    my ( $self, $c, %args ) = @_;

    my $host  = $c->req->uri->host;
    my $refer = $c->req->headers->referer;

    if ( !$refer || $refer !~ /^https?:\/\/$host/ ) {
        $refer = $c->uri_for('/');
    }
    my $mid = $c->set_error_msg(
        {
            #%args,
            form_error => $c->stash->{form_error},
            body       => $c->req->params,
            error_msg  => $c->stash->{error},
        }
    );
    my $uri = URI->new($refer);

    $uri->query_param( 'mid', $mid );
    $c->res->redirect( $uri->as_string );

}

sub as_json : Private {
    my ( $self, $c, $data ) = @_;

    $c->res->header( 'Content-type', 'application/json; charset=utf-8' );
    if ( ref $data eq 'HASH' && exists $data->{error} ) {
        $c->response->status(400);
    }

    $c->res->body( encode_json($data) );

}

sub redirect_relogin : Private {
    my ( $self, $c, %args ) = @_;

    my $host  = $c->req->uri->host;
    my $port  = $c->req->uri->port == 80 ? '' : ":" . $c->req->uri->port;
    my $refer = $c->req->headers->referer;

    if ( !$refer || $refer !~ /^https?:\/\/$host$port/i ) {
        $refer = '/erro';
    }
    if ( $c->req->method eq 'GET' ) {
        $refer = $c->req->uri->as_string;
    }

    my $mid = $c->set_error_msg(
        {
            form_error => {},
            body       => {},
            error_msg  => 'Sessão expirada. Faça o login novamente.',
        }
    );

    $refer =~ s/^https?:\/\/$host$port//g;

    my $uri = URI->new('/login');
    $uri->query_param( 'mid',         $mid );
    $uri->query_param( 'redirect_to', $refer );

    $c->res->redirect( $uri->as_string );
}

__PACKAGE__->meta->make_immutable;

1;
