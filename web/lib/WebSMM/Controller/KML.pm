package WebSMM::Controller::KML;
use Moose;
use namespace::autoclean;
use URI;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;
    $self->status_bad_request( $c, message => 'invalid.argument' ), $c->detach
      unless $id =~ /^[0-9]+$/;

    my $url = $c->req->uri->path;
    if (   ( $url =~ /variable_config$/ || $url =~ /variable_config\/\d+$/ )
        && $c->user->id != $id
        && $c->req->method eq 'GET' )
    {

        $self->status_forbidden(
            $c, message => "access denied for $id | log is " . $c->user->id
          ),
          $c->detach
          unless $c->check_any_user_role(qw(user));

    }
    else {
        $self->status_forbidden( $c, message => "access denied", ), $c->detach
          unless $c->user->id == $id
          || $c->check_any_user_role(qw(admin superadmin));
    }

    $c->stash->{object} =
      $c->stash->{collection}->search_rs( { 'me.id' => $id } );
    $c->stash->{object}->count > 0 or $c->detach('/error_404');

}

sub kml_file : Chained('base') : PathPart('kml') : Args(0) ActionClass('REST') {
    my ( $self, $c ) = @_;
}

sub kml_file_POST {
    my ( $self, $c ) = @_;

    $self->status_forbidden( $c, message => "access denied", ), $c->detach
      unless $c->check_any_user_role(qw(admin superadmin user));
    my $upload = $c->req->upload('arquivo');

    eval {
        if ($upload) {
            my $user_id = $c->user->id;

            $c->logx( 'Enviou KML ' . $upload->basename );

            my $file = $c->model('KML')->process(
                user_id => $user_id,
                upload  => $upload,
                schema  => $c->model('DB'),
                app     => $c
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

__PACKAGE__->meta->make_immutable;

1;
