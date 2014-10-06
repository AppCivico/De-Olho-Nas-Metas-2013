package SMM::Role::Verification;
use namespace::autoclean;
use Moose::Role;

use SMM::Data::Manager;
use Data::Diver qw(Dive);

use JSON qw(encode_json);
has verifiers => (
    is         => 'ro',
    isa        => 'HashRef',
    lazy_build => 1,
    builder    => 'verifiers_specs'
);

has actions => (
    is         => 'ro',
    isa        => 'HashRef',
    lazy_build => 1,
    builder    => 'action_specs'
);

requires 'verifiers_specs';
requires 'action_specs';

sub check {
    my ( $self, %args ) = @_;

    my $path  = delete $args{for};
    my $input = delete $args{with};

    my $verifier = Dive( $self->verifiers, split( /\./, $path ) );
    my $action   = Dive( $self->actions,   split( /\./, $path ) );

    return SMM::Data::Manager->new(
        input     => $input,
        verifiers => { $path => $verifier },
        actions   => { $path => $action }
    );
}

sub execute {
    my ( $self, $c, %args ) = @_;

    my $dm     = $self->check(%args);
    my $result = $dm->apply;

    $c->controller('API')
      ->status_bad_request( $c, message => encode_json( $dm->errors ) ),
      $c->detach
      unless $dm->success;

    return wantarray ? ( $dm, $result ) : $result;
}

1;
