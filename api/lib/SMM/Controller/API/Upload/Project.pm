
package SMM::Controller::API::Upload::Project;

use Moose;
use JSON;
use SMM::Types qw/DataStr TimeStr/;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/upload/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub configuration_goal : Chained('base') : PathPart('projects') : Args(0)
  : ActionClass('REST') {

}

sub configuration_goal_POST {
    my ( $self, $c ) = @_;

    my %header = (
        name    => qr /\bnome\b/io,
        address => qr /\bendere.o\b/io,

        latitude  => qr /\blatitude\b/io,
        longitude => qr /\blongitude\b/io,

        budget_executed        => qr /\bor.amento executado\b/io,
        goal_id                => qr /\bid da meta\b/io,
        region_id              => qr /\bid da região\b/io,
        percentage             => qr /\bporcentagem\b/io,
        qualitative_progress_1 => qr /\bprogresso qualitativo 1\b/io,
        qualitative_progress_2 => qr /\bprogresso qualitativo 2\b/io,
        qualitative_progress_3 => qr /\bprogresso qualitativo 3\b/io,
        qualitative_progress_4 => qr /\bprogresso qualitativo 4\b/io,
        qualitative_progress_5 => qr /\bprogresso qualitativo 5\b/io,
        qualitative_progress_6 => qr /\bprogresso qualitativo 6\b/io,
    );
    $c->stash->{db}       = $c->model('DB::Goal');
    $c->stash->{header}   = \%header;
    $c->stash->{validate} = sub {
        my $line = shift;
        my $dv   = Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name                   => { required => 0, type => 'Str' },
                address                => { required => 0, type => 'Str' },
                latitude               => { required => 0, type => 'Str' },
                longitude              => { required => 0, type => 'Str' },
                budget_executed        => { required => 0, type => 'Int' },
                goal_id                => { required => 0, type => 'Int' },
                region_id              => { required => 0, type => 'Int' },
                percentage             => { required => 0, type => 'Int' },
                qualitative_progress_1 => { required => 0, type => 'Str' },
                qualitative_progress_2 => { required => 0, type => 'Str' },
                qualitative_progress_3 => { required => 0, type => 'Str' },
                qualitative_progress_4 => { required => 0, type => 'Str' },
                qualitative_progress_5 => { required => 0, type => 'Str' },
                qualitative_progress_6 => { required => 0, type => 'Str' },
            }
        );
        my $results = $dv->verify($line);

        return 1 if $results->success;

        my @res = $results->invalids;
        my @message;
        push @message, $results->get_field($_) for @res;

    };
    my $lol = $c->forward('/api/uploadfile/file');
}

1;
