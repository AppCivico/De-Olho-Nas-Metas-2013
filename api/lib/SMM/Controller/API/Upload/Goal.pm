
package SMM::Controller::API::Upload::Goal;

use Moose;
use JSON;
use SMM::Types qw/DataStr TimeStr/;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/upload/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub configuration_goal : Chained('base') : PathPart('goals') : Args(0)
  : ActionClass('REST') {

}

sub configuration_goal_POST {
    my ( $self, $c ) = @_;

    my %header = (
        name        => qr /\bnome\b/io,
        description => qr /\bdescri..o\b/io,

        technically       => qr /\bdescri..o t.cnica\b/io,
        will_be_delivered => qr /\bobjetivo de entrega\b/io,

        expected_start_date    => qr /\bexpectativa de come.o\b/io,
        expected_end_date      => qr /\bexpectativa de fim\b/io,
        percentage             => qr /\bporcentagem\b/io,
        goal_number            => qr /\bn.mero da meta\b/io,
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
        use DDP;
        my $dv = Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                name                   => { required => 0, type => 'Str' },
                description            => { required => 0, type => 'Str' },
                technically            => { required => 0, type => 'Str' },
                will_be_delivered      => { required => 0, type => 'Str' },
                expected_start_date    => { required => 0, type => DataStr },
                expected_end_date      => { required => 0, type => DataStr },
                percentage             => { required => 0, type => 'Int' },
                goal_number            => { required => 0, type => 'Int' },
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
        p \@message;
        p \@res;

    };
    my $lol = $c->forward('/api/uploadfile/file');
    use DDP;
    p $lol;
    warn 1234567;
}

1;
