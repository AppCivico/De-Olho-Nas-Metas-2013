package WebSMM::Controller::PromiseTracker::Campaign;
use Moose;
use namespace::autoclean;
use JSON;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::PromiseTracker::Campaign - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/promisetracker/base') :PathPart('campaign') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
	$c->stash->{url} = 'http://dev.monitor.promisetracker.org/api/v1/campaigns';
}

sub object :Chained('base') :PathPart('') : CaptureArgs(1){
    my ( $self, $c, $id ) = @_;
	my $return;

	$c->detach unless $id =~ /^\d+$/;
	
	my $model = $c->model('API');

	$c->stash->{url} .= '/'.$id;

	eval{
	    $return = $model->_do_http_req(
			method => 'GET',
			url    => $c->stash->{url},
		);
	};

	my $json = decode_json $return->content;
	$c->stash->{campaign} = $json->{payload}->{campaign};
}
sub index :Chained('base') :Args(0){
    my ( $self, $c ) = @_;
	
	my $return;
	my $res;

	my $model = $c->model('API');

	my $url = 'http://dev.monitor.promisetracker.org/api/v1/campaigns';
	
	eval{
		$return = $model->_do_http_req(
			method => 'GET',
			url    => $url,
		);
	};

	my $data = decode_json $return->content;
	$c->stash->{campaigns} = $data->{payload};
}

sub detail :Chained('object') :Args(0){
    my ( $self, $c ) = @_;
}
sub create :Chained('base') :Args(0){
    my ( $self, $c ) = @_;
	
	my $return;
	my $res;

	my $model = $c->model('API');

	my $url = 'http://dev.monitor.promisetracker.org/api/v1/campaigns';
	
	eval{
		$return = $model->_do_http_req(
			method => 'POST',
			url    => $url,
		);
	};

	my $data = decode_json $return->content;
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
