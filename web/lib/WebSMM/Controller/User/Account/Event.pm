package WebSMM::Controller::User::Account::Event;
use Moose;
use namespace::autoclean;
use JSON;
use utf8;
use URI;
use Path::Class qw(dir);
use File::Copy;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/user/account/base') : PathPart('event') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template_wrapper} = 'func';
    my $api = $c->model('API');
    $api->stash_result(
        $c,
        [ 'users', $c->user->obj->id ],
        stash => 'user_roles',
    );
    $c->stash->{user_obj}->{role} =
      { map { $_ => 1 } @{ $c->stash->{user_roles}->{roles} } };
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    $c->detach( '/form/redirect_error', [] ) unless $c->user;

    $c->stash->{id} = $id;
}

sub edit : Chained('object') : PathPart('editar') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'campaigns', $c->stash->{id} ],
        stash => 'campaign_obj'
    );
}

sub remove : Chained('object') : PathPart('remover') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'campaigns', $c->stash->{id} ],
        method => 'DELETE',
        stash  => 'campaign_obj'
    );
    $c->detach(
        '/form/redirect_ok',
        [

            '/user/account/campaign',
            {},
            'Removido com sucesso!',

        ]
    );

}

sub update : Chained('object') : PathPart('atualizar') : Args(0) {
    my ( $self, $c ) = @_;

    my $api    = $c->model('API');
    my $form   = $c->model('Form');
    my $params = { %{ $c->req->params } };

    my $avatar = $c->req->upload('avatar');

    $form->format_date( $params, qw/end_on start_in/ );

    $params->{latlng} =~ s/\(|\)//g if $params->{latlng};
    if ( $params->{latlng} ) {
        ( $params->{latitude}, $params->{longitude} ) = split ',',
          $params->{latlng};
    }
    $params->{address} = delete $params->{txtaddress};

    $api->stash_result(
        $c,
        [ 'campaigns', $c->stash->{id} ],
        method => 'PUT',
        stash  => 'campaign_obj',
        body   => $params
    );
    my $path = dir( $c->config->{campaign_picture_path} )->resolve . '/'
      . $c->stash->{id};

    unless ( -e $path ) {
        mkdir $path;
    }

    $avatar->copy_to( $path . '/' . $c->stash->{id} . '.jpg' ) if $avatar;

    $c->detach(
        '/form/redirect_ok',
        [

            '/user/account/campaign',
            {},
            'Alterado com sucesso!',

        ]
    );
}

__PACKAGE__->meta->make_immutable;

1;
