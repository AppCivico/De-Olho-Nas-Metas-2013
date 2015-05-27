
package SMM::Controller::API::UploadFile;

use Moose;
use JSON;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

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
    eval {
        if ($upload) {
            my $user_id = $c->user->id;

            my $file = $c->model('File')->process(
                user_id => $user_id,
                upload  => $upload,
                header  => $c->stash->{header},
                schema  => $c->stash->{db},
                config  => $c->stash->{config},
                app     => $c,
            );

            $c->res->body( to_json($file) );

        }
        else {
            die "no upload found\n";
        }
    };
    print STDERR " >>>>> $@" if $@;
    $c->res->body( to_json( { error => "$@" } ) ) if $@;

    $c->detach;

}

1;
