package SMM::TraitFor::Controller::AutoObject;

use Moose::Role;
requires 'object';

around object => sub {
    my $orig   = shift;
    my $self   = shift;
    my $config = $self->config;

    my ( $c, $id ) = @_;

    $self->status_bad_request( $c, message => 'invalid.int' ), $c->detach
      unless $id =~ /^[0-9]+$/;

    $c->stash->{object} = $c->stash->{collection}->search( { "me.id" => $id } );
    $c->stash->{ $config->{object_key} } = $c->stash->{object}->next;

    $c->detach('/error_404') unless defined $c->stash->{ $config->{object_key} };

    $self->$orig(@_);
};

1;

