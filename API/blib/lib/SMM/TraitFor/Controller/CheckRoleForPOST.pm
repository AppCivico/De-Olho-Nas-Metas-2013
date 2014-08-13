package SMM::TraitFor::Controller::CheckRoleForPOST;

use Moose::Role;

requires 'list_POST';

around list_POST => sub {
    my $orig   = shift;
    my $self   = shift;
    my $config = $self->config;

    my ( $c, $id ) = @_;
    my $do_detach = 0;

    if ( !$c->check_any_user_role( @{ $config->{create_roles} } ) ) {
        $self->status_forbidden( $c, message => "insufficient privileges" );
        $c->detach;
    }

    $self->$orig(@_);
};

1;

