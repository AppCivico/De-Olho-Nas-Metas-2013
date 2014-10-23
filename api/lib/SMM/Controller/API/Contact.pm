package SMM::Controller::API::Contact;
use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result      => 'DB::PreRegister',
    object_key  => 'preregister',
);

with 'SMM::TraitFor::Controller::DefaultCRUD';

sub base : Chained('/api/base') : PathPart('contacts') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :  ActionClass('REST') { }
sub result_PUT {
    my ( $self, $c ) = @_;

    my $params       = { %{ $c->req->params } };
    my $preregister = $c->stash->{preregister};

    $preregister->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $preregister->id ] )
          ->as_string,
        entity => { id => $preregister->id }
      ),
      $c->detach  if $preregister;

}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_POST {
    my ( $self, $c ) = @_;

    my $preregister = $c->stash->{collection}
      ->execute( $c, for => 'create', with => $c->req->params );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $preregister->id ] )
          ->as_string,
        entity => {
            id => $preregister->id
        }
    );
}

sub list_GET {
    my ( $self, $c ) = @_;

    $self->status_ok(
        $c,
        entity => {
            preregister => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              /
                        ),
                        city => {
                            (
                                map { $_ => $r->{city}{$_}, }
                                  qw/
                                  id
                                  name
                                  /
                            ),
                            state => {
                                (
                                    map { $_ => $r->{city}{state}{$_}, }
                                      qw/
                                      id
                                      name
                                      /
                                )
                            }
                        },
                        url => $c->uri_for_action(
                            $self->action_for('result'),
                            [ $r->{id} ]
                        )->as_string
                      }
                } $c->stash->{collection}->as_hashref->all
            ]
        }
    );
}

sub complete : Chained('base') : PathPart('complete') : Args(0) {
    my ( $self, $c ) = @_;

    my $preregister;

    $c->model('DB')->txn_do(
        sub {
			use DDP;

            $preregister = $c->stash->{collection}->execute( $c, for => 'create', with => $c->req->params );

		}       
    );

    $self->status_created(
        $c,
        location =>
          $c->uri_for( $self->action_for('result'), [ $preregister->id ] )
          ->as_string,
        entity => {
            id => $preregister->id
        }
    );

}

=head1 NAME

SMM::Controller::API::PreRegister - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut




=encoding utf8

=head1 AUTHOR

development,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
