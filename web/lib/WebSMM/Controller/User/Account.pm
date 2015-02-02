package WebSMM::Controller::User::Account;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/user/base') : PathPart('') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('perfil') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
		
}

sub index : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

#	$c->stash->{avatar} = dir($c->config->{profile_picture_path})->resolve.'/'.$c->user->id.'/'.$c->user->id.'jpg';
	
	
}

sub follow : Chained('object') : PathPart('seguindo') :Args(0){
    my ( $self, $c ) = @_;

}

sub security :Chained('object') :PathPart('seguranca') :Args(0){
    my ( $self, $c ) = @_;

	return unless $c->req->method eq 'POST';	
	
	my $api = $c->model('API');

	$api->stash_result(
		$c,
		[ 'users', $c->user->id ],
		method => 'PUT',
		params => $c->req->params,
	);
			
}

sub edit :Chained('object') :PathPart('editar') :Args(0){
    my ( $self, $c ) = @_;

	my $api = $c->model('API');

	$api->stash_result(
		$c,
		[ 'users', $c->user->id ],
		stash => 'user_obj',
	);
	
	return unless $c->req->method eq 'POST';


	$api->stash_result(
		$c,
		[ 'users', $c->user->id ],
		method => 'PUT',
		params => $c->req->params,
	);

}
__PACKAGE__->meta->make_immutable;

1;
