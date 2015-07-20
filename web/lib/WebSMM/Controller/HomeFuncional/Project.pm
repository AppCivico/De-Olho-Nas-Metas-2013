package WebSMM::Controller::HomeFuncional::Project;
use Moose;
use namespace::autoclean;
use JSON;
use Path::Class qw(dir);
use utf8;
use DDP;
use DateTime::Format::DateParse;

#use DateTime;
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::HomeFuncional::Project - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/homefuncional/base') : PathPart('project') :
  CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

    $api->stash_result( $c, 'regions' );
    $api->stash_result( $c, 'objectives' );

}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');
    my $user_id = $c->user->obj->id if $c->user;

    $c->stash->{id} = $id;
    $api->stash_result(
        $c,
        [ 'projects', $id ],
        stash  => 'project_obj',
        params => { user_id => $user_id ? $user_id : '' }
    );
    if ( $c->user ) {
        $api->stash_result(
            $c,
            [ 'users', $c->user->obj->id ],
            stash => 'user_obj',
        );
        $c->stash->{user_obj}->{role} =
          { map { $_ => 1 } @{ $c->stash->{user_obj}->{roles} } };

        $c->stash->{do_i_follow} =
          grep { $_ eq $id } @{ $c->stash->{user_obj}->{projects_i_follow} };
    }
}

sub detail : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c, $id ) = @_;
    my $count = 0;
    for my $n ( 1 .. 6 ) {
        $count++ if $c->stash->{project_obj}->{ 'qualitative_progress_' . $n };
    }
    $c->stash->{project_obj}->{progress_count} = $count;

    $c->stash->{users_question} =
      { map { $_->{user} => 1 }
          @{ $c->stash->{project_obj}->{users_question} } };
    $c->stash->{statistic} =
      { map { $_->{progress} => $_->{percentage} }
          @{ $c->stash->{project_obj}->{statistic} } };

}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, 'projects' );
}

sub type : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;

    my $type_id = $c->req->param('type_id');
    my $api     = $c->model('API');

    my $res = $api->stash_result(
        $c,
        'projects',
        params => {
            type_id => $type_id
        }
    );
    $c->stash->{without_wrapper} = 1;
}

sub region : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach unless $c->req->param('region_id');
    $c->detach unless $c->req->param('region_id') =~ /^\d+$/;

    my $region_id = $c->req->param('region_id');
    my $api       = $c->model('API');

    my $res = $api->stash_result(
        $c,
        'projects',
        params => {
            region_id => $region_id
        }
    );
    $c->stash->{without_wrapper} = 1;
}

sub region_by_cep : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;

    $c->detach unless $c->req->param('latitude');
    $c->detach unless $c->req->param('longitude');

    $c->detach unless $c->req->param('latitude') =~ qr/^(\-?\d+(\.\d+)?)$/;
    $c->detach unless $c->req->param('longitude') =~ qr/^(\-?\d+(\.\d+)?)$/;

    my $lnglat =
      join( q/ /, $c->req->param('longitude'), $c->req->param('latitude') );

    my $api = $c->model('API');

    my $res = $api->stash_result(
        $c,
        'projects',
        params => {
            lnglat => $lnglat
        }
    );
    $c->stash->{message} = 1 if $c->stash->{error};
    $c->stash->{without_wrapper} = 1;

}

sub user_follow_project : Chained('base') : PathPart('user_follow_project') :
  Args(0) {

    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $user_id    = $c->req->param('user_id');
    my $project_id = $c->req->param('project_id');

    $api->stash_result(
        $c,
        'user_follow_project',
        method => 'POST',
        params => { user_id => $user_id, project_id => $project_id },
    );
    $c->res->status(400), $c->detach unless $c->stash->{project};
    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body( encode_json( $c->stash->{project} ) );

}

sub user_stop_follow : Chained('base') : PathPart('user_stop_follow') : Args(0)
{
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $user_id    = $c->req->param('user_id');
    my $project_id = $c->req->param('project_id');

    $api->stash_result(
        $c,
        [ 'users', $user_id, 'project', $project_id ],
        method => 'POST',
    );

    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body( encode_json( { message => 'parou de seguir' } ) );

}

sub comment_counsil : Chained('base') : PathParth('comment_counsil') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $user_id    = $c->req->param('user_id');
    my $text       = $c->req->param('text');
    my $project_id = $c->req->param('project_id');

    $api->stash_result(
        $c,
        'project_events',
        method => 'POST',
        params =>
          { user_id => $user_id, text => $text, project_id => $project_id }
    );

    $api->stash_result( $c, 'project_events',
        params =>
          { project_id => $project_id, approved => 'true', active => 1 } );

    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body(
        encode_json(
            {
                message =>
'Seu comentário foi enviado para moderação, aguarde aprovação.'
            }
        )
    );
}

sub comment : Chained('base') : PathParth('comment') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $user_id    = $c->req->param('user_id');
    my $text       = $c->req->param('text');
    my $project_id = $c->req->param('project_id');

    $user_id = 53 unless $c->req->param('user_id');
    $api->stash_result(
        $c,
        'comment_projects',
        method => 'POST',
        params => {
            user_id     => $user_id,
            description => $text,
            project_id  => $project_id
        }
    );

    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body(
        encode_json(
            {
                message =>
'Seu comentário foi enviado para moderação, aguarde aprovação.'
            }
        )
    );
}

sub search_by_types : Chained('base') : Args(0) {
    my ( $self, $c ) = @_;
    my $lat  = $c->req->param('latitude');
    my $long = $c->req->param('longitude');
    my $lnglat;
    if ( $lat && $long ) {
        $lat  = "" unless $lat =~ qr/^(\-?\d+(\.\d+)?)$/;
        $long = "" unless $long =~ qr/^(\-?\d+(\.\d+)?)$/;

        $lnglat = join( q/ /, $long, $lat );
    }
    my $type_id   = $c->req->param('type_id');
    my $region_id = $c->req->param('region_id');
    my $api       = $c->model('API');

    my $res = $api->stash_result(
        $c,
        'projects',
        params => {
            region_id => $region_id ? $region_id : "",
            type_id   => $type_id   ? $type_id   : "",
            lnglat    => $lnglat    ? $lnglat    : ""
        }
    );
    use DDP;
    my $now = DateTime->now( time_zone => 'local' );

    for my $p ( @{ $c->stash->{projects} } ) {
        next unless $p->{updated_at};
        my $dt =
          DateTime::Format::DateParse->parse_datetime( $p->{updated_at} );
        $dt = $dt->add( days => 7 );

        $p->{set_updated} = 1 if $now < $dt;

    }
    $c->res->status(200);
    $c->detach( '/form/as_json', [ { projects => $c->stash->{projects} } ] );
}

sub upload_images : Chained('object') : PathPart('upload_images') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');
    $c->detach unless $c->req->method eq 'POST';
    my $image  = $c->req->upload('files[]');
    my $params = { %{ $c->req->params } };
    my $path   = dir( $c->config->{project_picture_path} )->resolve . '/'
      . $c->stash->{id};
    my $user_id = $c->user->obj->id if $c->user;
    unless ( -e $path ) {
        mkdir $path;
    }
    my $address_html = '/static/images/project/' . $c->stash->{id} . '/';
    $api->stash_result(
        $c,
        'images_project',
        method => 'POST',
        body   => {
            project_id  => $c->stash->{id},
            name_image  => $address_html . $image->filename,
            description => $params->{description},
            user_id     => $user_id
        }
    );

    my $data = {
        name      => $image->filename,
        size      => $image->size,
        url       => $path . '/' . $image->filename,
        deleteUrl => $path . '/' . $image->filename
    };
    my $response = ();
    push( @{ $response->{files} }, $data );
    p $response;
    $image->copy_to( $path . '/' . $image->filename );

    p $image;
    p $c->stash->{images_project};
    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body( encode_json($response) );
}

sub project_autocomplete : Chained('base') : PathPart('project_autocomplete')
  : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $c->detach unless $c->req->method eq 'POST';
    $api->stash_result( $c, ['projects/autocomplete'],
        params => { project_name => $c->req->params->{project_name} } );
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }

    $c->res->status(200);
    $c->res->content_type('application/json');
    $c->res->body( encode_json( $c->stash->{projects} ) );
}

=encoding utf8

=head1 AUTHOR

development,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
