
package SMM::Controller::API::UploadFile;

use Moose;
use JSON;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with 'CatalystX::Eta::Controller::TypesValidation';

sub do : Chained('/api/base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    $self->status_forbidden( $c, message => "access denied", ), $c->detach
      unless $c->check_any_user_role(qw(admin superadmin user));
    my $upload = $c->req->upload('file');
    die \[ 'upload', 'missing content' ] unless $upload;

    my $user_id = $c->user->id;
    my $res;
    $res = $c->model('File')->process(
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

        # $c->res->code(400);
        $c->stash->{rest} = $res;
        $c->detach;
    }

    unlink $upload->tempname;

    $self->status_accepted( $c, entity => $res );

}

1;
