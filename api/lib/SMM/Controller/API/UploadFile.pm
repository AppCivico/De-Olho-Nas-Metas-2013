
package SMM::Controller::API::UploadFile;

use Moose;
use JSON;

BEGIN { extends 'Catalyst::Controller::REST' }

sub base : Chained('/api/base') : PathPart('upload_file') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub file : Chained('base') : PathPart('') : Args(0) ActionClass('REST') {
    my ( $self, $c ) = @_;
}

sub file_POST {
    my ( $self, $c ) = @_;

    $self->status_forbidden( $c, message => "access denied", ), $c->detach
      unless $c->check_any_user_role(qw(admin superadmin user));
    my $upload = $c->req->upload('file');

    die \[ 'upload', 'missing content' ] unless $upload;

    my $user_id = $c->user->id;

    my $res = $c->model('File')->process(
        user_id  => $user_id,
        upload   => $upload,
        header   => $c->stash->{header},
        schema   => $c->stash->{db},
        config   => $c->stash->{config},
        validate => $c->stash->{validate},
        fk       => $c->stash->{fk},
        app      => $c,
    );

    if ( $res->{status}{error} ) {
        $c->res->code(400);
        $c->detach;
    }

    unlink $upload->tempname;

    $self->status_accepted( $c, entity => $res );

}

1;
