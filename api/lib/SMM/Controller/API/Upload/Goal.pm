
package SMM::Controller::API::Upload::Goal;

use Moose;
use JSON;

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

        expected_start_date    => qr /\bexpectativa de começo\b/io,
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
    $c->stash->{db}     = $c->model('DB::Goal');
    $c->stash->{header} = \%header;
    $c->stash->{config} = sub { my $column = shift; };

    $c->detach('/api/uploadfile/file');

}

1;
