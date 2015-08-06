package WebSMM::Model::API;
use base 'Catalyst::Model';
use Moose;
use utf8;
use URI;
use Furl;
use URI::QueryParam;
use Encode;
use DateTime;
use JSON::XS;

has my_config => (
    is  => 'rw',
    isa => 'HashRef',
);

sub initialize_after_setup {
    my ( $self, $app ) = @_;
    $app->log->debug('Initializing NV2::AppLoja::Model::UserAgent...');
    $self->my_config( $app->config );

    die "ERROR: please configure api_url\n" unless $app->config->{api_url};

    $app->config->{api_url} .= '/' unless $app->config->{api_url} =~ /\/$/;
}

=pod

faz uma requisicao GET para listagens e carrega o retorno na stash

=cut

use HTTP::Request::Common;

sub stash_result {
    my ( $self, $c, $endpoint, %opts ) = @_;

    $endpoint = join( '/', @$endpoint ) if ( ref $endpoint eq 'ARRAY' );

    my $url =
      exists $opts{api_url}
      ? $opts{api_url} . $endpoint
      : $c->config->{api_url} . $endpoint;

    $url .= $self->_generate_query_params( $c, %opts );

    my @headers = $self->_generate_headers($c);
    if ( exists $opts{body} && ref $opts{body} eq 'HASH' ) {
        $opts{body} = { %{ $opts{body} } };

        while ( my ( $k, $v ) = each %{ $opts{body} } ) {
            $v = '' unless defined $v;
            $opts{body}{$k} = encode( 'UTF-8', $v );
        }
    }

    my $method = lc( $opts{method} || 'GET' );

    my $res;
    use DDP;
    p \@headers;

    if ( $method eq 'upload' ) {
        $res = eval {
            my $req = POST $url, @headers,
              Content_Type => 'form-data',
              Content      => $opts{body};

            $self->furl->request($req);
        };
    }
    else {

        $res = eval {
            $self->_do_http_req(
                method  => $method,
                url     => $url,
                headers => [@headers],
                exists $opts{body} ? ( body => $opts{body} ) : ()
            );
        };
        p $res;

        #print STDERR $res->as_string;
    }
    if ($@) {
        $c->stash( error => "$method $endpoint", error_content => $@ );
        $c->detach('/rest_error');
    }

    if ( $res->code == 403 && $res->content =~ /key expired/ ) {
        $c->logout;
        $c->detach( '/form/redirect_relogin', [] );
    }

    if ( !exists $opts{exp_code}
        && $res->code !~ /^(200|201|202|204|404|410|400)$/ )
    {
        $c->stash(
            error => "ERROR WHILE $method $endpoint CODE ${\$res->code}",
            error_content => $res->content,
            error_code    => $res->code,
            error_url     => $url
        );
        $c->detach('/rest_error');
    }

    if ( $c->debug ) {

        # colocando todos os resultados na stash, porque eu acho que vai ficar
        # mais facil se quiser montar um erro com todos os resultados
        push @{ $c->stash->{backtrace} },
          {
            method   => $method,
            endpoint => $endpoint,
            content  => $res->content,
            time     => DateTime->now->datetime
          };
    }
    return if $res->code =~ /^(410|204)$/;

    # TODO talvez algum endpoint nao precisa de parser.

    return $res->content if $opts{get_as_content};

    my $obj = eval { decode_json $res->content };

    if ($@) {
        $c->stash(
            error         => "Error while trying parse JSON.",
            error_content => $res->content,
            error_code    => "JSON",
            error_url     => $url
        );
        $c->detach('/rest_error');
    }

    if ( exists $opts{exp_code} && $res->code !~ $opts{exp_code} ) {
        return undef if $opts{get_result};

        $c->stash(
            error =>
"ERROR WHILE $method $endpoint CODE ${\$res->code} ISN'T $opts{exp_code}",
            error_content => $res->content,
            error_code    => $res->code,
            error_url     => $url
        );
        $c->detach('/rest_error');
    }

    # tratando caso espcial do retorno em json do bad-request
    if ( $res->code == 400 && $obj->{error} =~ /^{/ && $obj->{error} =~ /}$/ ) {
        my $missing = eval { decode_json $obj->{error} };
        $obj->{form_error} = $missing;
        $obj->{error}      = 'Formulário inválido';
    }

    return $obj if $opts{get_result};

    my $ref = $opts{stash} ? $c->stash->{ $opts{stash} } ||= {} : $c->stash;

    # merge hashs without rewrite a new
    @{$ref}{ keys %$obj } = values %$obj;

    if ( $c->debug ) {

    }

    return 1;
}

sub get_result {
    my ( $self, $c, $endpoint, %opts ) = @_;

    return $self->stash_result( $c, $endpoint, %opts, get_result => 1 );
}

sub _generate_headers {
    my ( $self, $c ) = @_;

    my $api_key;
    if ( !$c->user ) {
        $api_key = $c->config->{api_user_api_key};
    }
    else {
        $api_key = $c->user->api_key;
    }

    return ( 'X-API-Version', 1, 'X-API-Key', $api_key );

}

sub _generate_query_params {
    my ( $self, $c, %opts ) = @_;

    return '' unless exists $opts{params};

    my @aa =
      ref $opts{params} eq 'HASH' ? %{ $opts{params} } : @{ $opts{params} };
    my $str = '?';

    my $url = '';
    while (@aa) {
        my ( $k, $v ) = ( ( shift @aa ), ( shift @aa ) );

        $v = '' if !defined $v;
        my $u = URI->new( "", "http" );
        $u->query_form( $k => $v );

        next unless $u->query;

        $url .= $str . $u->query;

        $str = '&';
    }
    return $url;
}

sub _do_http_req {
    my ( $self, %args ) = @_;

    my $method = uc $args{method};
    my $res;

    if ( $method =~ /^GET/o ) {
        $res = $self->furl->get( $args{url}, $args{headers} );
    }
    elsif ( $method =~ /^POST/o ) {
        $res = $self->furl->post( $args{url}, $args{headers}, $args{body} );
    }
    elsif ( $method =~ /^PUT/o ) {
        $res = $self->furl->put( $args{url}, $args{headers}, $args{body} );
    }
    elsif ( $method =~ /^DELETE/o ) {
        $res = $self->furl->delete( $args{url}, $args{headers} );
    }
    else {
        die('not supported method');
    }

    return $res;
}

sub furl {
    return Furl->new(
        agent   => 'WebSMM',
        timeout => 100
    );
}

1;
