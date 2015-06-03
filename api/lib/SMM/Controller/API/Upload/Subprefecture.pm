
package SMM::Controller::API::Upload::Subprefecture;

use Moose;
use JSON;
use SMM::Types qw/DataStr TimeStr/;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/upload/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub configuration : Chained('base') : PathPart('subprefectures') : Args(0)
  : ActionClass('REST') {

}

sub configuration_POST {
    my ( $self, $c ) = @_;

    my %header = (
        name         => qr /\bnome\b/io,
        acronym      => qr /\bsigla\b/io,
        latitude     => qr /\blatitude\b/io,
        longitude    => qr /\blongitude\b/io,
        site         => qr /\bsite\b/io,
        deputy_mayor => qr /\bsubprefeito\b/io,
        email        => qr /\bemail\b/io,
        telephone    => qr /\btelefone\b/io,
        address      => qr /\bendereço\b/io,
    );
    $c->stash->{db}       = $c->model('DB::Region');
    $c->stash->{header}   = \%header;
    $c->stash->{validate} = sub {
        my $line = shift;
        my $dv   = Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name         => { required => 1, type => 'Str' },
                acronym      => { required => 0, type => 'Str' },
                latitude     => { required => 0, type => 'Str' },
                longitude    => { required => 0, type => 'Str' },
                site         => { required => 0, type => 'Str' },
                deputy_mayor => { required => 0, type => 'Str' },
                email        => { required => 0, type => 'Str' },
                telephone    => { required => 0, type => 'Str' },
                address      => { required => 0, type => 'Str' },
            }
        );
        my $results = $dv->verify($line);

        return 1 if $results->success;

        my @res = $results->invalids;
        my @message;
        push @message, $results->get_field($_) for @res;

    };
    $c->forward('/api/uploadfile/file');
}

1;
