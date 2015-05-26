
package SMM::Controller::API::Upload;

use Moose;
use JSON;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/base') : PathPart('upload') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

1;
