
package SMM::Controller::API::Upload::District;

use Moose;
use JSON;
use SMM::Types qw/DataStr TimeStr/;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/upload/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub configuration : Chained('base') : PathPart('districts') : Args(0)
  : ActionClass('REST') {

}

sub configuration_POST {
    my ( $self, $c ) = @_;

    my %header = (
        name             => qr /\bnome\b/io,
        lat              => qr /\blatitude\b/io,
        long             => qr /\blongitude\b/io,
        subprefecture_id => qr /\bid da subprefeitura\b/io,
        geom             => qr /\bgeom\b/io,
    );
    $c->stash->{db}       = $c->model('DB::Region');
    $c->stash->{header}   = \%header;
    $c->stash->{validate} = sub {
        my $line = shift;
        my $dv   = Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name             => { required => 1, type => 'Str' },
                lat              => { required => 0, type => 'Str' },
                long             => { required => 0, type => 'Str' },
                subprefecture_id => { required => 1, type => 'Int' },
                geom             => { required => 0, type => 'Str' },
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
